package com.sea.autoCode.testCode;

import java.io.File;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sea.autoCode.BaseCodeCreator;
import com.sea.autoCode.config.Config;
import com.sea.autoCode.util.AutoCodeUtil;

public class TestCodeCreator extends BaseCodeCreator {

    public void createTestCodeByClassName (String fclassName) throws ClassNotFoundException {
        Class <?> cls = Class.forName (fclassName);

        String simpleName = cls.getSimpleName ();

        String filePath = simpleName + "Test.java";
        Map <String, Object> map = new HashMap <String, Object> ();

        List <String> mNames = new ArrayList <String> ();
        Method[] methods = cls.getDeclaredMethods ();
        for (Method method : methods) {
            if (Modifier.isPublic (method.getModifiers ())) {
                mNames.add (method.getName ());
            }

        }
        Integer hasInterface = 0;
        if (!cls.isInterface ()) {
            if (cls.getInterfaces ().length > 0) {
                cls = cls.getInterfaces ()[0];
                hasInterface = 1;
            }
        }

        map.put ("javaName", simpleName);
        map.put ("interface", cls.getSimpleName ());
        map.put ("methods", mNames);
        map.put ("hasInterface", hasInterface);
        map.putAll (config.get ());
        createCodeByTemplate (map, "JunitTestCode.ftl", filePath);
    }

    /*
     * public void createTestCode () throws ClassNotFoundException { String
     * className = config.get ("fclassName"); this.createTestCodeByClassName
     * (className); }
     */

    protected Config createConfig () {
        Config config = new Config ("/com/autoCode/config/testConfg.properties");
        return config;
    }

    public void createTestCodeByClasPath (String filePath, String[] preFix) throws ClassNotFoundException {
        List <File> files = AutoCodeUtil.getJavaFiles (new File (filePath), preFix);
        for (File f : files) {
            String fullCls = AutoCodeUtil.getFullClass (f, "com");
            this.createTestCodeByClassName (fullCls);
        }
    }

    public static void main (String[] args) throws ClassNotFoundException {
        TestCodeCreator autoCode = new TestCodeCreator ();
        autoCode.createTestCodeByClassName ("com.yihaodian.backend.finance.purchaseInvoice.service.impl.InvoiceSourceOrderServiceImpl");
        /*
         * autoCode.createTestCodeByClasPath (
         * "D:\\work\\Invoice_Projects\\backend-finance-nap-web\\src\\main\\java\\com\\yihaodian\\backend\\finance\\accountspayable\\service\\applyOrder\\impl"
         * , new String[] { "Impl.java" });
         */
    }
}
