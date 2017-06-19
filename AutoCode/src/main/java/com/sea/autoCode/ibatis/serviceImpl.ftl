package ${serviceImplPackage};

import com.yihaodian.backend.finance.accountspayable.dto.base.Pagination;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${daoPackage}.${daoName};
import ${servicePackage}.${serviceName};

public class ${serviceImplName} implements ${serviceName}{

     private ${daoName}  ${(daoName) ? uncap_first};
     
     
	/**
	 * 分页查询
	 * @param dto
	 * @return
	 */
	public Pagination find${javaName}Pg(${dtoName} dto){
	
	  return this.${(daoName) ? uncap_first}.find${javaName}Pg(dto);
	}
	
	
	/**
	 * 根据Id查询
	 * @param id
	 * @return
	 */
	public ${dtoName} get${javaName}(Long id){
	   return this.${(daoName) ? uncap_first}.get(id);
	}
	
	
	/**
	 * 插入数据
	 * @param dto
	 * @return
	 */
	public Long create${javaName}(${moName} dto){
	   return this.${(daoName) ? uncap_first}.insert${javaName}(dto);
	}
	
	
	 public void set${daoName}(${daoName} dao){
        this.${(daoName) ? uncap_first}=dao;
     }
	
	
}