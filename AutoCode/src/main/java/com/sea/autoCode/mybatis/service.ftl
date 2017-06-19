package ${servicePackage};

import java.util.List;
import com.angel.dmds.common.mybatis.BaseDto;
import com.angel.dmds.common.mybatis.PgDto;
import com.angel.dmds.common.mybatis.Pagination;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};

public interface ${serviceName}{


	/**
	 * 分页查询
	 * @param dto
	 * @return
	 */
	public Pagination<${dtoName}> find${javaName}Pg(${dtoName} dto);
	
	/**
	 * 查询
	 * @param dto
	 * @return
	 */
	public List<${dtoName}> find${javaName}List(${dtoName} dto);
	
	
	/**
	 * 根据Id查询
	 * @param id
	 * @return
	 */
	public ${dtoName} get${javaName}(Long id);
	
	
	/**
	 * 插入数据
	 * @param dto
	 * @return
	 */
	public Long create${javaName}(${moName} ${moName?uncap_first});
	
	
	/**
	 * 修改数据
	 * @param dto
	 * @return
	 */
	public int update${javaName}(${moName} ${moName?uncap_first});
	
	
	/**
	 * 删除数据
	 * @param ids
	 * @return
	 */
    public int delete${moName}ByIds(List<Long> ids); 
    
    /**
	 * 删除数据，id
	 * @param id
	 * @return
	 */
    public int delete${moName}ById(Long id); 
	
	
}