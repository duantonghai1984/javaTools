package ${daoPackage};

import java.util.List;
import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ${javaName}Mapper{
	
	
	/**
	 * 具体最大数量1万
	 * @param dto
	 * @return
	 */
	public List<${dtoName}> find${javaName}List(${dtoName} dto);
	

	
	/**
	 * 插入数据
	 * @param dto
	 * @return
	 */
	public Long insert${javaName}(${moName} ${moName?uncap_first});
	
	
	
	/**
	 * 统计数目
	 * @param dto
	 * @return
	 */
	public int count${javaName}(${dtoName} dto);
	
	/**
	 * 更新数据，只根据id或者ids更新
	 * @param dto
	 * @return
	 */
    public int update${javaName}ByIds(${moName} ${moName?uncap_first});
    
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