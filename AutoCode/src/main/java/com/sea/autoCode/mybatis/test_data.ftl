<?xml version="1.0" encoding="UTF-8"?>

<dataset>
    <!--
      <#if columns??>
	           <#list columns as template>
	           ${template.columnName}  注释： ${(template.remark)!''}
	           </#list>
		</#if>
    -->

	<${tableName}
	       <#if columns??>
	           		<#list columns as template>  ${template.columnName}=" "   <#if template_index%4==0 >
	            
	            	</#if></#list>
		   </#if>
	/>
</dataset>		
	
  


		

	