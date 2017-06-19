package com.sea.autoCode.testCode;

import java.io.File;
import java.lang.reflect.Field;
import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sea.autoCode.BaseCodeCreator;
import com.sea.autoCode.config.Config;
import com.sea.autoCode.util.AutoCodeUtil;

/**
 * ---- 请加注释 ------
 * 
 * @Author duantonghai
 * @CreateTime 2014-7-8 上午11:48:43
 */
public class TestDtoCreator extends BaseCodeCreator {

    public void createDtoTestByPath (String classPath) {
        File file = new File (classPath);
        List <File> files = AutoCodeUtil.getJavaFiles (file, new String[] { "Dto.java", "Mo.java" });
        System.out.println (files.size ());
        createTest (files);
    }

    private void createTest (List <File> files) {
        String filePath = "DtoJunitTest.java";
        StringBuffer buff = new StringBuffer ();
        StringBuffer buffImport = new StringBuffer ();
        for (File f : files) {
            String fullCls = AutoCodeUtil.getFullClass (f, "com");
            try {
                buff.append (this.createDtoJunitByClass (fullCls));
            }
            catch (Error e1) {
                e1.printStackTrace ();
            }
            catch (Exception e) {
                e.printStackTrace ();
            }

        }

        System.out.println (buff.toString ());
        Map <String, Object> map = new HashMap <String, Object> ();
        map.put ("content", buff.toString ());
        map.put ("import", buffImport.toString ());
        map.putAll (config.get ());
        createCodeByTemplate (map, "JunitDtoTest.ftl", filePath);
    }

    /**
     * 根据反射返回测试程序
     * 
     * @param fullCls
     * @return
     * @throws Exception
     */
    public String createDtoJunitByClass (String fullCls) throws Exception {
        StringBuffer buff = new StringBuffer ();

        Class <?> cls = null;
        try {
            cls = Class.forName (fullCls);
            if (cls.isInterface ()) {
                return buff.toString ();
            }
        }
        catch (Error e) {
            e.printStackTrace ();
        }
        if (cls == null) {
            return buff.toString ();
        }

        buff.append ("\n\n@Test\n");
        String clsName = cls.getSimpleName ();
        buff.append ("public void test" + clsName + "( ){\n");
        buff.append (clsName + " dto =new " + clsName + "();\n");

        for (Field field : cls.getDeclaredFields ()) {
            try {
                String Mname = field.getName ().substring (0, 1).toUpperCase () + field.getName ().substring (1);
                if (Mname.equalsIgnoreCase ("SerialVersionUID")) {
                    continue;
                }

                System.out.println ("Mname" + Mname);

                if (Mname.equalsIgnoreCase ("Pg")) {
                    continue;
                }

                if (cls.getMethod ("get" + Mname, null) == null) {
                    continue;
                }

                boolean isNull = false;
                buff.append ("dto.set" + Mname + "(");
                if (field.getType ().isAssignableFrom (Long.class)) {
                    buff.append ("1l");
                }
                else if (field.getType ().isAssignableFrom (String.class)) {
                    buff.append ("\"test\"");
                }
                else if (field.getType ().isAssignableFrom (BigDecimal.class)) {
                    buff.append ("BigDecimal.ONE");
                }
                else if (field.getType ().isAssignableFrom (Integer.class)) {
                    buff.append ("1");
                }
                else if (field.getType ().isAssignableFrom (Boolean.class)) {
                    buff.append ("true");
                }
                else if (field.getType ().isAssignableFrom (Date.class)) {
                    buff.append ("new Date()");
                }
                else if (field.getType () == int.class) {
                    buff.append ("1");
                }
                else {
                    buff.append ("null");
                    isNull = true;
                }

                buff.append (");\n");
                if (isNull) {
                    buff.append ("Assert.assertNull( dto.get" + Mname + "());\n\n");
                }
                else {
                    buff.append ("Assert.assertNotNull( dto.get" + Mname + "());\n\n");
                }
            }
            catch (Error e) {

            }
            catch (Exception m) {

            }

        }
        buff.append ("}");
        return buff.toString ();
    }

    @Override
    protected Config createConfig () {
        Config config = new Config ("/com/autoCode/config/testConfg.properties");
        return config;
    }

    public static void main (String[] args) throws ClassNotFoundException {
        TestDtoCreator test = new TestDtoCreator ();
        try {
            /*
             * String res = test.createDtoJunitByClass (
             * "com.yihaodian.backend.finance.purchaseInvoice.dto.InvoiceSourceOrderDto"
             * ); System.out.println (res);
             */
            test.createDtoTestByPath ("D:\\work\\Invoice_Projects\\backend-finance-nap-web\\src\\main\\java");
        }
        catch (Exception e) {

        }
    }
}
