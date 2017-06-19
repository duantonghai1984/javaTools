package com.sea.autoCode.config;

import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import org.apache.commons.lang3.StringUtils;


public class Config {

	 private  Properties properties = new Properties(); 
	 private  Map<String,String> params=null;
	 
	 public static final String defalut_config="/com/sea/autoCode/config/devConfg.properties";
	
     
     /**
      * 1 dev, other test
      * @param type
      */
     public Config(String configPath){
    	 if(StringUtils.isEmpty(configPath)){
    		 configPath=defalut_config;
    	 }
    	 try  
         {  
             InputStream inputStream = Config.class.getResourceAsStream(configPath); 
             properties.load(inputStream); 
             inputStream.close(); //关闭流  
             
             load();
         } catch (IOException e)  
         {  
             e.printStackTrace();  
         }
     }
     
     
     private  Map<String,String> load(){
    	 if(params!=null){
    		 return params;
    	 }
    	 Map<String,String> map=new HashMap<String,String>();
    	 Enumeration<Object> enumer=properties.keys();
    	 while(enumer.hasMoreElements()){
    		 String key=(String)enumer.nextElement();
    		 map.put(key, properties.getProperty(key).trim());
    	 }
    	 params=map;
    	 map.put("moName", map.get("javaName"));
    	 map.put("dtoName", map.get("javaName")+"Dto");
    	 map.put("daoName", map.get("javaName")+"Dao");
    	 map.put("daoImplName", map.get("javaName")+"DaoImpl");
    	 map.put("serviceName", map.get("javaName")+"Service");
    	 map.put("serviceImplName", map.get("javaName")+"ServiceImpl");
    	 
    	 return params;
     }
     
     
     public  Map<String,String> get(){
    	 if(params!=null){
    		 return params;
    	 }
    	 load();
    	 return params;
     }
     
     public String get(String key){
    	 return this.get().get(key);
     }
     
	

}
