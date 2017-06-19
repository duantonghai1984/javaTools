package com.sea.autoCode.devCode;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sea.autoCode.BaseCodeCreator;
import com.sea.autoCode.config.Config;
import com.sea.autoCode.devCode.vo.Cloumn;
import com.sea.autoCode.util.DatabaseHelpler;

public class DevCodeCreator extends BaseCodeCreator {

    private List <Cloumn> cloumns;

    public DevCodeCreator (Connection connection) {
        this.cloumns = getTableColumns (connection, config.get ().get ("tableName"));
        System.out.println ("column size:" + this.cloumns.size ());
    }

    private List <Cloumn> getTableColumns (Connection connection, String tableName) {
        try {
            if (connection == null || connection.isClosed ()) {
                throw new RuntimeException ("null db connection");
            }
            return this.cloumns = DatabaseHelpler.getColumns (connection, config.get ().get ("tableName"));
        }
        catch (Exception e) {
            throw new RuntimeException (e.getMessage (), e);
        }
        finally {
            try {
                connection.close ();
            }
            catch (SQLException e) {
                throw new RuntimeException (e.getMessage (), e);
            }
        }
    }

    @Override
    protected void createCodeByTemplate (Map <String, Object> paras, String templateName, String fileName) {
        Map <String, Object> root = new HashMap <String, Object> ();
        root.putAll (config.get ());
        root.put ("columns", this.cloumns);
        if (paras != null && !paras.isEmpty ()) {
            root.putAll (paras);
        }
        super.createCodeByTemplate (root, templateName, fileName);
    }

    @Override
    protected Config createConfig () {
        Config config = new Config ("/com/autoCode/config/devConfg.properties");
        return config;
    }

    public void createTestData () {
        createCodeByTemplate (null, "test_data.ftl", config.get ("tableName").toLowerCase () + ".xml");
    }

    public void createIbatis () {
        String javaName = config.get ("javaName");
        javaName = javaName.substring (0, 1).toLowerCase () + javaName.substring (1);
        createCodeByTemplate (null, "ibatis.ftl", "sqlmap-" + javaName + ".xml");
    }

    public void createJavaMo () {
        String filePath = config.get ("javaName") + ".java";
        filePath = getFinalFilePath (filePath, config.get ("moPackageName"));
        createCodeByTemplate (null, "mo.ftl", filePath);
    }

    public void createJavaDto () {
        String filePath = config.get ("javaName") + "Dto.java";
        filePath = getFinalFilePath (filePath, config.get ("dtoPackageName"));
        createCodeByTemplate (null, "dto.ftl", filePath);
    }

    public void createJavaDao () {
        String filePath = config.get ("javaName") + "Dao.java";
        filePath = getFinalFilePath (filePath, config.get ("daoPackage"));
        createCodeByTemplate (null, "dao.ftl", filePath);
    }

    public void createJavaDaoTest () {
        String filePath = config.get ("javaName") + "DaoTest.java";
        filePath = getFinalFilePath (filePath, "");
        createCodeByTemplate (null, "daoTest.ftl", filePath);
    }

    public void createJavaDaoImpl () {
        String filePath = config.get ("javaName") + "DaoImpl.java";
        filePath = getFinalFilePath (filePath, config.get ("daoImplPackage"));
        createCodeByTemplate (null, "daoImpl.ftl", filePath);
    }

    public void createJavaService () {
        String filePath = config.get ("javaName") + "Service.java";
        filePath = getFinalFilePath (filePath, config.get ("servicePackage"));
        createCodeByTemplate (null, "service.ftl", filePath);
    }

    public void createJavaServiceImpl () {
        String filePath = config.get ("javaName") + "ServiceImpl.java";
        filePath = getFinalFilePath (filePath, config.get ("serviceImplPackage"));
        createCodeByTemplate (null, "serviceImpl.ftl", filePath);
    }

    /**
     * @param args
     * @throws SQLException
     */
    public static void main (String[] args) throws SQLException {
     
    	Connection con=null;
        try{
        Class.forName("com.mysql.jdbc.Driver").newInstance();  
         con = DriverManager.getConnection("jdbc:mysql://localhost:3306/doc",  
                "root", "root"); 
        }catch(Exception e){
        	e.printStackTrace();
        }
        
        DevCodeCreator autoCode = new DevCodeCreator (con);

        autoCode.createIbatis ();
        autoCode.createJavaMo();
        autoCode.createJavaDto();
        autoCode.createJavaDao();
        autoCode.createJavaDaoImpl();
        
        // autoCode.createJavaService();
        // autoCode.createJavaServiceImpl();
         autoCode.createJavaDaoTest ();

        /*
         * autoCode.createJavaDao(); autoCode.createJavaDaoImpl();
         * autoCode.createJavaService(); autoCode.createJavaServiceImpl()
         */;

        autoCode.createTestData ();
        System.exit (1);
    }

}
