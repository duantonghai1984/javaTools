package ${moPackageName};


import java.math.BigDecimal;
import java.util.Date;
import java.io.Serializable;

public class ${javaName} extends Serializable{

private static final long serialVersionUID = 1L;

<#if columns??>
	<#list columns as template>

	  <#if template.nullable ==0>
	  //${(template.remark)!''}  #不允许为空    
	  <#else>
	  //${(template.remark)!''}  #允许空
	  </#if>
	  private ${template.javaType.simpleName}  ${template.javaAtrName};
	  
	</#list>
	
	
	<#list columns as template>

	 
	  public ${template.javaType.simpleName} get${(template.javaAtrName) ? cap_first}(){
	         return this.${template.javaAtrName};
	  }
	  
	  public void set${(template.javaAtrName) ? cap_first}(${template.javaType.simpleName} value){
	         this.${template.javaAtrName}=value;
	  }
	  
	</#list>
	
</#if>


}