package ${dtoPackageName};

import java.util.List;

import com.yihaodian.backend.finance.service.model.voucher.VoucherConfigInfo;
import com.yihaodian.backend.framework.common.ibatis.PgDto;
import com.yihaodian.backend.framework.common.model.BaseDto;
import com.yihaodian.backend.framework.common.netJson.JsonDisable;


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
	 <!--
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
	  -->
	</#list>
   </#if>



   private List<Long> ids;
   
    public List <Long> getIds (){
        return ids;
    }

   public void setIds (List <Long> ids){
        this.ids = ids;
    }
}