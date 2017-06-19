package ${moPackageName};


import java.math.BigDecimal;
import java.util.Date;
import java.io.Serializable;
import com.angel.dmds.common.mo.BaseMo;

/**
    对应数据表  ${tableName}
**/
public class ${javaName} extends BaseMo implements Serializable{

	private static final long serialVersionUID = 1L;
<#if columns??>
	<#list columns as template>		  
	  <#if template.javaAtrName !='id' && template.javaAtrName !='gmtCreated' && template.javaAtrName !='gmtModified' && template.javaAtrName !='creator'  && template.javaAtrName !='modifier'  && template.javaAtrName !='isDeleted'>
	   	 <#if template.nullable ==0>
	//${(template.remark)!''}  #不允许为空    
		  <#else>
	//${(template.remark)!''}  #允许空
		  </#if>
	private ${template.javaType.simpleName}  ${template.javaAtrName};
	
	  </#if>
	</#list>	
	<#list columns as template>
		<#if template.javaAtrName !='id' && template.javaAtrName !='gmtCreated' && template.javaAtrName !='gmtModified' && template.javaAtrName !='creator'  && template.javaAtrName !='modifier'  && template.javaAtrName !='isDeleted'>
	public ${template.javaType.simpleName} get${(template.javaAtrName) ? cap_first}(){
		return this.${template.javaAtrName};
	}
		  
	public void set${(template.javaAtrName) ? cap_first}(${template.javaType.simpleName} value){
		this.${template.javaAtrName}=value;   
	}
	  </#if>
	</#list>
	
</#if>


}