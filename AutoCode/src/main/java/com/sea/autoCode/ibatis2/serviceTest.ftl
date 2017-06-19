package ${servicePackage};

import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.yihaodian.backend.finance.DbSpringTest;
import com.yihaodian.backend.finance.accountspayable.dto.base.Pagination;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${servicePackage}.${serviceName};
import ${daoPackage}.${daoName};


public class ${serviceImplName}Test extends  DbSpringTest{

     @Autowired
     private ${serviceName}  ${(serviceName) ? uncap_first};
     
    @Override
    public String[] getDataFilePaths() {
        return new String[]{ "${testDataSetDir}${tableName}.xml" };
    }
     
     
	@Test
	public void find${javaName}Pg(){
	   ${dtoName} dto=new ${dtoName}();
	    dto.setId(1l);
	    Pagination pg=this.${(serviceName) ? uncap_first}.find${javaName}Pg (dto);
	    Assert.assertNotNull (pg);
	}
	
	
	@Test
	public void get(){
	    ${dtoName} dto=this.${(serviceName) ? uncap_first}.get${javaName} (1l);
	    Assert.assertNotNull (dto);
	}
	
	
	
}