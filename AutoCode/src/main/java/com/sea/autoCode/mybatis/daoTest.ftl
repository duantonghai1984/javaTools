package ${daoPackage};

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import org.junit.Assert;
import org.junit.Test;
import com.angel.core.doc.common.ibatis.Pagination;
import com.angel.core.doc.base.BaseServiceTestCase;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${daoPackage}.${daoName};


public class ${daoName}Test   extends BaseServiceTestCase{

  @Resource
   private ${daoName}  ${(daoName) ? uncap_first};



	@Test
	public void find${javaName}Pg(){
	    ${dtoName} dto=new ${dtoName}();
	    dto.setId(1l);
	    Pagination pg=this.${(daoName) ? uncap_first}.find${javaName}Pg (dto);
	    Assert.assertNotNull (pg);
	}
	
	
	@Test
	public void testFind${javaName}List(){
	 	 ${dtoName} dto=new ${dtoName}();
	 	 dto.setId(1l);
	    List<${dtoName}> pg=this.${(daoName) ? uncap_first}.find${javaName}List (dto);
	    Assert.assertNotNull (pg);
	}
	
	
	
	@Test
	public void get(){
	    ${dtoName} dto=this.${(daoName) ? uncap_first}.get (1l);
	    Assert.assertNotNull (dto);
	}
	
	

    @Test	
	public void testInsert${javaName}(){
	   ${dtoName} dto=new ${dtoName}();
	    Long  id=this.${(daoName) ? uncap_first}.insert${javaName} (dto);
	    Assert.assertNotNull (id);
	}
	
	
	
	@Test
	public void testUpdate${javaName}(){
	  
	}
	
	
	@Test
	public void testCount${javaName}(){
	     ${dtoName} dto=new ${dtoName}();
	    int pg=this.${(daoName) ? uncap_first}.count${javaName} (dto);
	    Assert.assertNotNull (pg);
	}
	
}