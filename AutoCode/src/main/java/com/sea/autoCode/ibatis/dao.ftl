package ${daoPackage};


import com.yihaodian.backend.finance.accountspayable.dto.base.Pagination;
import java.util.List;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};

public interface ${daoName}{


	/**
	 * 分页查询
	 * @param dto
	 * @return
	 */
	public Pagination find${javaName}Pg(${dtoName} dto);
	
	
	/**
	 * 具体最大数量1万
	 * @param dto
	 * @return
	 */
	public List<${dtoName}> find${javaName}List(${dtoName} dto);
	
	
	
	/**
	 * 根据Id查询
	 * @param id
	 * @return
	 */
	public ${dtoName} get(Long id);
	
	
	/**
	 * 插入数据
	 * @param dto
	 * @return
	 */
	public Long insert${javaName}(${moName} dto);
	
	
	/**
	 * 逻辑删除数据
	 * @param dto
	 * @return
	 */
	public int delete(Long id);
}