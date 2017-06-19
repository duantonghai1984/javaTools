package ${testPackage};


import org.junit.Assert;
import org.junit.Test;

import javax.annotation.Resource;
import com.yihaodian.backend.finance.accountspayable.dto.base.Pagination;
import org.springframework.beans.factory.annotation.Autowired;
import com.yihaodian.backend.finance.DbSpringTest;

import ${fclassName};

public class ${javaName}Test extends DbSpringTest {

   <#if hasInterface==1 >
   @Autowired
   <#else>
   @Resource
   </#if>
   private ${interface}  ${(interface) ? uncap_first};
	
	
	<#if methods??>
	<#list methods as template>
	
	@Test
	public void test${(template) ? cap_first}(){
	     //TODO
	}
	   
	</#list>
   </#if>
	
}