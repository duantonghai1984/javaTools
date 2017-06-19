package ${daoImplPackage};

import java.util.Date;
import java.util.List;

import com.yihaodian.backend.finance.accountspayable.dto.base.Pagination;
import com.yihaodian.backend.finance.common.constant.Constants;
import com.yihaodian.backend.finance.common.ibatis.IbatisDaoSupport;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${daoPackage}.${daoName};

public class ${daoImplName} extends IbatisDaoSupport<${dtoName},Long>  implements ${daoName}{


	public ${daoImplName}() {
		super("${javaName}");
	}

	@Override
	public Pagination find${javaName}Pg(${dtoName} dto){
	    return this.findObjectsWithPg("find${javaName}Pg", dto);
	}
	
	
	@SuppressWarnings("unchecked")
	@Override
	public List<${dtoName}> find${javaName}List(${dtoName} dto){
	 	dto.getPg().setLimit(MAX_QUERY_SIZE);
		return this.getSqlMapClientTemplate().queryForList("find${javaName}Pg", dto);
	}
	
	
	/**
	 * 根据Id查询
	 * @param id
	 * @return
	 */
	@Override
	public ${dtoName} get(Long id){
	     ${dtoName} dto=new ${dtoName}();
	     dto.setId(id);
	    return (${dtoName})this.getForObjct(this.find${javaName}List(dto));
	}
	
	
	/**
	 * 插入数据
	 * @param dto
	 * @return
	 */
	@Override
	public Long insert${javaName}(${moName} dto){
	   return (Long)this.getSqlMapClientTemplate().insert("insert${javaName}", dto);
	}
	
	
	/**
	 * 逻辑删除数据
	 * @param dto
	 * @return
	 */
	@Override
	public int delete(Long id){
	   //TODO 
	    return this.getSqlMapClientTemplate().update("delete${javaName}", id);
	}
	
}