package ${daoPackage};

import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yihaodian.backend.finance.DbSpringTest;
import com.yihaodian.backend.finance.accountspayable.dto.base.Pagination;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${daoPackage}.${daoName};


public class ${daoName}Test extends  DbSpringTest{

  @Autowired
   private ${daoName}  ${(daoName) ? uncap_first};

 	@Override
    public String[] getDataFilePaths() {
        return new String[]{ "${testDataSetDir}${tableName}.xml" };
    }


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