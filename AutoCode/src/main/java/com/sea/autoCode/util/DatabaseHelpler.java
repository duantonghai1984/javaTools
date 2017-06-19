package com.sea.autoCode.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.sea.autoCode.devCode.vo.Cloumn;

public class DatabaseHelpler {

    public static List <Cloumn> getColumns (Connection finCon, String tableName) {
        Map <String, Cloumn> map = new HashMap <String, Cloumn> ();
        System.out.println (tableName);
        try {

            StringBuffer buff = new StringBuffer ();
          
            /*buff.append ("select t.column_id ,t.TABLE_NAME,t.COLUMN_NAME,t.DATA_TYPE,t.DATA_LENGTH,t.DATA_SCALE,t.NULLABLE,col.comments");
            buff.append (" from user_tab_columns t,all_col_comments col ");
            buff.append (" where t.table_name =?  and col.table_name=t.table_name and col.column_name=t.COLUMN_NAME  order by t.column_id asc");
            */
            
            buff.append("select t.ORDINAL_POSITION as column_id,t.table_name,t.column_name,t.DATA_TYPE,t.NUMERIC_PRECISION as DATA_LENGTH,t.NUMERIC_SCALE as DATA_SCALE,t.IS_NULLABLE as NULLABLE,t.COLUMN_COMMENT as comments from information_schema.columns t where t.TABLE_NAME=?");
            System.out.println(buff.toString());
            PreparedStatement statment = finCon.prepareStatement (buff.toString ());
            statment.setString (1, tableName.toUpperCase ());
            ResultSet colRet = statment.executeQuery ();
            while (colRet.next ()) {
                Cloumn column = new Cloumn (colRet.getLong ("column_id"), colRet.getString ("COLUMN_NAME"),
                                            colRet.getString ("DATA_TYPE"), colRet.getInt ("DATA_LENGTH"),
                                            colRet.getInt ("DATA_SCALE"),
                                            colRet.getString ("NULLABLE").contains ("Y") ? 1 : 0,
                                            colRet.getString ("comments"));
                if (map.get (colRet.getString ("COLUMN_NAME")) == null) {
                    map.put (colRet.getString ("COLUMN_NAME"), column);
                }
            }

        }
        catch (SQLException e) {
            e.printStackTrace ();
        }

        List <Cloumn> columns = new ArrayList <Cloumn> ();
        Iterator <Cloumn> iter = map.values ().iterator ();
        while (iter.hasNext ()) {
            columns.add (iter.next ());
        }

        Collections.sort (columns, new Comparator <Cloumn> () {
            @Override
            public int compare (Cloumn v1, Cloumn v2) {
                if (v1 == v2) {
                    return 0;
                }
                else if (v1.getColumnId () > v2.getColumnId ()) {
                    return 1;
                }
                else {
                    return -1;
                }
            }
        });
        return columns;
    }

    public static List <Cloumn> getColumns2 (Connection finCon, String tableName) {

        Map <String, Cloumn> map = new HashMap <String, Cloumn> ();

        System.out.println (tableName);
        try {
            ResultSet colRet = finCon.getMetaData ().getColumns (null, "%", tableName.trim ().toUpperCase (), "%");

            while (colRet.next ()) {
                Cloumn column = new Cloumn (1l, colRet.getString ("COLUMN_NAME"), colRet.getString ("TYPE_NAME"),
                                            colRet.getInt ("COLUMN_SIZE"), colRet.getInt ("DECIMAL_DIGITS"),
                                            colRet.getInt ("NULLABLE"), colRet.getString ("REMARKS"));
                /*
                 * int count=colRet.getMetaData().getColumnCount(); for(int
                 * i=1;i<count;i++){
                 * System.out.println(colRet.getMetaData().getColumnLabel(i)); }
                 */

                if (map.get (colRet.getString ("COLUMN_NAME")) == null) {
                    column.setRemark (getColumnComment (finCon, tableName, column.getColumnName ()));
                    map.put (colRet.getString ("COLUMN_NAME"), column);
                }

            }

        }
        catch (SQLException e) {
            e.printStackTrace ();
        }/*
          * finally{ try { if(finCon!=null){ finCon.close(); } } catch
          * (SQLException e) { e.printStackTrace(); } }
          */

        List <Cloumn> columns = new ArrayList <Cloumn> ();
        Iterator <Cloumn> iter = map.values ().iterator ();
        while (iter.hasNext ()) {
            columns.add (iter.next ());
        }
        return columns;
    }

    public static String getColumnComment (Connection finCon, String tableName, String columnName) {
        try {
            PreparedStatement statment = finCon.prepareStatement ("select COMMENTS from all_col_comments col where col.table_name=?  and col.column_name=?");
            statment.setString (1, tableName.toUpperCase ());
            statment.setString (2, columnName.toUpperCase ());
            String comments = "";
            ResultSet set = statment.executeQuery ();
            while (set.next ()) {
                comments = set.getString ("COMMENTS");
            }
            return comments;
        }
        catch (Exception e) {
            e.printStackTrace ();
        }
        return "";
    }
}
