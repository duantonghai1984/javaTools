package ${servicePackage};

import com.yihaodian.backend.finance.accountspayable.dto.base.Pagination;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${daoPackage}.${daoName};

public interface ${serviceName}{


	/**
	 * 分页查询
	 * @param dto
	 * @return
	 */
	public Pagination find${javaName}Pg(${dtoName} dto);
	
	
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
	public Long create${javaName}(${moName} dto);
	
	
}