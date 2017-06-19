package com.sea.autoCode.util;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * ---- 请加注释 ------
 * 
 * @Author duantonghai
 * @CreateTime 2014-10-11 下午5:39:20
 */
public class AutoCodeUtil {

    /**
     * 获得指定目录下的java类文件列表
     * 
     * @param dir
     * @param prefix
     * @return
     */
    public static List <File> getJavaFiles (File dir, String[] prefix) {
        if (prefix == null || prefix.length < 1) {
            prefix = new String[] { "java" };
        }
        List <File> files = new ArrayList <File> ();
        if (dir.isDirectory ()) {
            File[] filesList = dir.listFiles ();
            for (File file : filesList) {
                if (file.isDirectory ()) {
                    files.addAll (AutoCodeUtil.getJavaFiles (file, prefix));
                }
                else {
                    for (String str : prefix) {
                        if (file.getName ().endsWith (str) || file.getName ().endsWith (str + ".java")) {
                            files.add (file);
                            break;
                        }
                    }
                }
            }
        }
        else {
            files.add (dir);
        }
        return files;
    }

    /**
     * 根据给定的文件名字获取 全java class名称
     * 
     * @param f
     * @return
     */
    public static String getFullClass (File f, String startPackge) {
        int index = f.getAbsolutePath ().indexOf (startPackge);
        if (index == -1) {
            return null;
        }
        System.out.println ("file:" + f.getAbsolutePath ());
        String fullCls = f.getAbsolutePath ().substring (index).replace (File.separatorChar, '.');
        fullCls = fullCls.substring (0, fullCls.length () - 5);
        return fullCls;
    }

}
