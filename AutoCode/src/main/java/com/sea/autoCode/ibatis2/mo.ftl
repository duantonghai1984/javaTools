package ${moPackageName};


import java.math.BigDecimal;
import java.util.Date;
import java.io.Serializable;
import com.yihaodian.backend.framework.common.annotation.Validate;
import com.yihaodian.backend.framework.common.utils.NumberUtil;
/**
    对应数据表  ${tableName}
**/
public class ${javaName} implements Serializable{

private static final long serialVersionUID = 1L;

<#if columns??>
	<#list columns as template>
	  <#if (template.nullable ==0 ) >
	  //${(template.remark)!''}//不允许为空    
	  <#if  template.javaAtrName!='id'>
	  <#if (template.javaAtrName!='createTime' && template.javaAtrName!='isDelete') >
	  @Validate
	  </#if>
	  </#if>
	  <#else>
	  //${(template.remark)!''}//允许空
	  </#if>
	  private ${template.javaType.simpleName}  ${template.javaAtrName};
	  
	</#list>
	
	
	<#list columns as template>

	 
	  public ${template.javaType.simpleName} get${(template.javaAtrName) ? cap_first}(){
	         return this.${template.javaAtrName};
	  }
	  
	  public void set${(template.javaAtrName) ? cap_first}(${template.javaType.simpleName} value){
	         <#if template.javaType.simpleName == 'BigDecimal' >
	            this.${template.javaAtrName}= NumberUtil.formatAmount(value);
	         <#else>
	         this.${template.javaAtrName}=value;
	        </#if>    
	  }
	  
	</#list>
	
</#if>


}