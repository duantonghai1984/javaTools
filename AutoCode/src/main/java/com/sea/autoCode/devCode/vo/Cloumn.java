package com.sea.autoCode.devCode.vo;

import java.math.BigDecimal;
import java.sql.Date;

public class Cloumn {

    private Long columnId;
    private String columnName;
    private String columnType;

    private int datasize;

    private int digits = 0;

    private int nullable;

    private String remark;

    private Class <?> javaType = null;
    private String javaAtrName = null;

    public Cloumn (Long columnId, String columnName, String columnType, int datasize, int digits, int nullable,
                   String remark) {
        this.columnId = columnId;
        this.columnName = columnName;
        this.columnType = columnType;
        this.datasize = datasize;
        this.digits = digits;
        this.nullable = nullable;
        this.remark = remark != null ? remark.trim () : null;
        this.getJavaType ();
    }

    public String getColumnName () {
        return columnName;
    }

    public String getColumnType () {
        return columnType;
    }

    public int getDatasize () {
        return datasize;
    }

    public int getDigits () {
        return digits;
    }

    public int getNullable () {
        return nullable;
    }

    public String getRemark () {
        return remark;
    }

    public Class <?> getJavaType () {
        int intSize=10;
        if (javaType != null) {
            return javaType;
        }
        String columnType = this.getColumnType ().toUpperCase ();
        if (columnType.indexOf ("NUMBER") != -1 || columnType.indexOf ("INT")!=-1) {
            if (this.getDatasize () <= intSize) {
                javaType = Integer.class;
            }
            else if (this.getDatasize () > intSize) {
                if (this.getDigits () > 0) {
                    javaType = BigDecimal.class;
                }
                else {
                    javaType = Long.class;
                }
            }
        }
        else if (columnType.indexOf ("DATE") != -1 || columnType.indexOf ("DATETIME") != -1) {
            javaType = Date.class;
        }
        else {
            javaType = String.class;
        }

        return javaType;
    }

    public String getJavaAtrName () {
        if (javaAtrName != null) {
            return javaAtrName;
        }
        String name = this.getColumnName ().toLowerCase ();
        String[] namePart = name.split ("_");
        StringBuffer finalName = new StringBuffer ();
        finalName.append (namePart[0]);
        for (int i = 1; i < namePart.length; i++) {
            finalName.append (namePart[i].substring (0, 1).toUpperCase ());
            finalName.append (namePart[i].substring (1, namePart[i].length ()).toLowerCase ());
        }
        javaAtrName = finalName.toString ();
        return javaAtrName;
    }

    public void setRemark (String remark) {
        this.remark = remark;
    }

    public String toString () {
        return columnName + " " + columnType + " " + datasize + " " + digits + " " + remark + " "
               + this.getJavaAtrName () + " " + this.getJavaType ().getSimpleName ();
    }

    public Long getColumnId () {
        return columnId;
    }

}
