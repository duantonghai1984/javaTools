package com.sea.autoCode;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.net.URL;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;

import com.sea.autoCode.config.Config;

import freemarker.template.Configuration;
import freemarker.template.Template;

public abstract class BaseCodeCreator {
	
	protected Config config=null;
	
	protected Configuration cfg=new Configuration();
	
	private File templateDir=null;
	
	private boolean createPackageFolder=false;
	
	public BaseCodeCreator() {
		URL url=this.getClass().getResource("/com/autoCode/mybaits/dao.ftl");
		File file=new File(url.getFile());
		try {
			cfg.setDirectoryForTemplateLoading(file.getParentFile());
		} catch (IOException e) {
			 throw new RuntimeException(e.getMessage());
		}
		
		this.config=this.createConfig();
		
		validate();
		
		if("1".equals(config.get("ceatePackFolder"))){
			createPackageFolder=true;
		}
		
	}
	
	
	public void setTemplateDir(File file){
		if(file.exists() && file.isDirectory()){
			try {
				cfg.setDirectoryForTemplateLoading(file);
			} catch (IOException e) {
				 throw new RuntimeException(e.getMessage());
			}
		}
	}
	
	private void validate(){
		if(this.config==null){
			throw new RuntimeException("config 读取失败");
		}
		
		if(StringUtils.isEmpty(config.get("dir"))){
			throw new RuntimeException("dir 没有配置");
		}
	}
	
	
	
	protected void createCodeByTemplate(Map<String,Object> root,String templateName, String fileName){
		try {
			Template t=this.cfg.getTemplate(templateName);
			createCodeFile(fileName,root,t);
		} catch (Exception e) {
		    System.out.println ("table ERROR:"+fileName);
			throw new RuntimeException(e.getMessage ());
		}
	}
	
	
	private  File createCodeFile(String filePath,Map<String,Object> params,Template template){
		File file=new File(config.get("dir")+File.separator+filePath);
		 try{
			  if(!file.getParentFile().exists()){
				  file.getParentFile().mkdirs();
			  }
			  FileWriter  writer=new FileWriter(file);
			  template.process(params, writer);
		  }catch(Exception e){
			 //e.printStackTrace ();
			 throw new RuntimeException(e.getMessage (),e);
		  }
		 return file;
	}
	
	/**
	 * 
	 * @param fileName
	 * @param pDirInfo   
	 * @return
	 */
	protected String getFinalFilePath(String fileName,String packageInfo){
		String filePath=fileName;
		if(createPackageFolder){
			filePath=packageInfo.replace(".", File.separator)+File.separator+filePath;
		}
		return filePath;
	}
	
	protected abstract Config createConfig();

}
