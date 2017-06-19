package ${servicePackage};

import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import com.angel.dmds.common.mybatis.Pagination;
import com.angel.dmds.WebApplication;
import org.junit.Assert;
import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${servicePackage}.${serviceName};


@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@SpringBootTest(classes = WebApplication.class)
public class ${serviceName}Test{

	private static final Log log = LogFactory.getLog(UserServiceTest.class);

    @Resource
    private ${serviceName}  ${(serviceName) ? uncap_first};
     
     
	@Test
	public void find${javaName}Pg(){
	   ${dtoName} dto=new ${dtoName}();
	    dto.setId(1l);
	    Pagination<${dtoName}> pg=this.${(serviceName) ? uncap_first}.find${javaName}Pg (dto);
	    Assert.assertNotNull (pg);
	}
	
	
	@Test
	public void get${javaName}(){
	    ${dtoName} dto=this.${(serviceName) ? uncap_first}.get${javaName} (1l);
	    Assert.assertNotNull (dto);
	}
	
	@Test
	public void testUpdate${javaName}(){
		${dtoName} dto = new ${dtoName}();
		List<Long> ids = new ArrayList<Long>();
		ids.add(1L);
		ids.add(2L);
		dto.setIds(ids);
		dto.setId(3L);
		this.${(serviceName) ? uncap_first}.update${javaName}(dto);
	}
	
	@Test
	public void testInsert${javaName}(){
		${javaName} ${javaName?uncap_first} = new ${javaName}();
		this.${(serviceName) ? uncap_first}.create${javaName}(${javaName?uncap_first});
	}
	
	@Test
	public void testDelete${javaName}ById(){
		this.${(serviceName) ? uncap_first}.delete${javaName}ById(1L);
	}
	
	@Test
	public void testDelete${javaName}ByIds(){
		List<Long> ids = new ArrayList<Long>();
		ids.add(1L);
		ids.add(2L);
		this.${(serviceName) ? uncap_first}.delete${javaName}ByIds(ids);
	}	
	
}