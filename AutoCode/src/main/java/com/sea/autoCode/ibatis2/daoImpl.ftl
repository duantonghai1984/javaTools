package ${daoImplPackage};

import java.util.Date;
import java.util.List;

import com.yihaodian.backend.finance.service.dto.voucher.VoucherConfigInfoDto;
import com.yihaodian.backend.framework.common.ibatis.Pagination;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${daoPackage}.${daoName};


public class ${daoImplName} extends IbatisDaoSupport<${dtoName},Long>  implements ${daoName}{


	public ${daoImplName}() {
		super("${javaName}");
	}

	
	public Pagination find${javaName}Pg(${dtoName} dto){
	    return this.findObjectsWithPg("find${javaName}Pg", dto);
	}
	
	
	@SuppressWarnings("unchecked")
	
	public List<${dtoName}> find${javaName}List(${dtoName} dto,Integer ... max){
	 	dto.getPg().setStart (0);
	    if(max!=null && max.length>0 && max[0]<5000){
	        dto.getPg().setLimit(max[0]); 
	    }else{
	 	  dto.getPg().setLimit(5000);
	    }
		return this.getSqlMapClientTemplate().queryForList("find${javaName}Pg", dto);
	}
	
	
	/**
	 * 根据Id查询
	 * @param id
	 * @return
	 */
	
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
	
	public Long insert${javaName}(${moName} dto){
	   return (Long)this.getSqlMapClientTemplate().insert("insert${javaName}", dto);
	}
	
	
	
	public int update${javaName}(${moName} dto){
	   if(dto.getId()==null){
	      throw new IllegalArgumentException("id是空");
	    }
	   return this.getSqlMapClientTemplate().update("update${javaName}", dto);
	}
	
	
	
	public int count${javaName}(${dtoName} dto){
	    Object count = this.getSqlMapClientTemplate().queryForObject(
				"countFind${javaName}Pg", dto);
	    return Integer.parseInt(count.toString());
	}
	
}