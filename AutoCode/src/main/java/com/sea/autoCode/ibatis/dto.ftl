package ${dtoPackageName};


import com.yihaodian.backend.finance.accountspayable.dto.base.BaseDto;
import com.yihaodian.backend.finance.accountspayable.dto.base.PgDto;
import com.yihaodian.backend.finance.common.json.JsonDisable;


import ${moPackageName}.${javaName};


public class ${dtoName} extends ${javaName} implements PgDto{

private static final long serialVersionUID = 1L;


private BaseDto pg = new BaseDto();

	@JsonDisable
	public BaseDto getPg() {
		if (pg == null) {
			pg = new BaseDto();
		}
		return pg;
	}
	
	
	<#if columns??>
	<#list columns as template>
	  <#if template.javaType.simpleName =='Date' >
	    //${template.javaAtrName} 开始时间 
	   private String  ${template.javaAtrName}Start;
	   
	   //${template.javaAtrName} 结束时间 
	   private String  ${template.javaAtrName}End;
	   
	    public String get${(template.javaAtrName) ? cap_first}Start(){
	        return this.${template.javaAtrName}Start;
	    }
	    
	    public void set${(template.javaAtrName) ? cap_first}Start(String value){
	        this.${template.javaAtrName}Start=value;
	    }
	    
	    public String get${(template.javaAtrName) ? cap_first}End(){
	        return this.${template.javaAtrName}End;
	    }
	    
	    public void set${(template.javaAtrName) ? cap_first}End(String value){
	         this.${template.javaAtrName}End=value;
	    }
	  </#if>
	</#list>
   </#if>


}