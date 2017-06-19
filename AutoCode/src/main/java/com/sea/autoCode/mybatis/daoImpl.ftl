package ${daoImplPackage};

import java.util.Date;
import java.util.List;


import com.angel.core.doc.helper.ibatis.IbatisDaoSupport;
import com.angel.core.doc.common.ibatis.Pagination;
import java.util.Date;
import com.angel.core.doc.exception.DocException;
import com.taobao.tddl.client.sequence.exception.SequenceException;
import org.apache.commons.collections.CollectionUtils;
import com.taobao.tddl.client.sequence.Sequence;
import com.alibaba.fastjson.JSON;
import javax.annotation.Resource;

import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${daoPackage}.${daoName};

/**
    对应数据表  ${tableName} 的数据库操作dao实现
**/
public class ${daoImplName} extends IbatisDaoSupport<${dtoName},Long>  implements ${daoName}{

    @Resource
    protected Sequence  seq${javaName};


	public ${daoImplName}() {
		super("${javaName}");
	}

	
	public Pagination find${javaName}Pg(${dtoName} dto){
	    return this.findObjectsWithPg("${tableName}.find${javaName}Pg", dto);
	}
	
	
	@SuppressWarnings("unchecked")
	
	public List<${dtoName}> find${javaName}List(${dtoName} dto,Integer ... max){
	 	dto.getPg().setStart (0);
	    if(max!=null && max.length>0 && max[0]<IbatisDaoSupport.MAX_QUERY_SIZE){
	        dto.getPg().setLimit(max[0]); 
	    }else{
	 	  dto.getPg().setLimit(IbatisDaoSupport.DEF_QUERY_SIZE);
	    }
		return this.getSqlMapClientTemplate().queryForList("${tableName}.find${javaName}Pg", dto);
	}
	
	
	/**
	 * 根据Id查询
	 * @param id
	 * @return
	 */
	
	public ${dtoName} get(Long id){
	      if(id==null){
	        throw new NullPointerException("参数为空id");
	       }
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
	  if(dto.getId()==null){
	        try {
                dto.setId(this.getNextSeqValue());
            } catch (Exception e) {
               throw new DocException(e.getMessage(),e);
            }
	    }
	    
	   if(dto.getGmtCreated()==null){
	      dto.setGmtCreated(new Date());
	   }
	   
	   if(dto.getGmtModified()==null){
		      dto.setGmtModified(new Date());
		   }
	   
	   if(StringUtils.isBlank(dto.getCreator())){
		   dto.setCreator(Constants.DEF_USER);
	   }
	   
	   if(StringUtils.isBlank(dto.getModifier())){
		   dto.setModifier(Constants.DEF_USER);
	   }
	   
	   return (Long)this.getSqlMapClientTemplate().insert("${tableName}.insert${javaName}", dto);
	}
	
	
	public int count${javaName}(${dtoName} dto){
	    Object count = this.getSqlMapClientTemplate().queryForObject(
				"${tableName}.countFind${javaName}Pg", dto);
	    return Integer.parseInt(count.toString());
	}
	
	
	public int update${javaName}ByIds(${dtoName} dto){
	    if(dto.getGmtModified()==null){
			      dto.setGmtModified(new Date());
			}
		
		 if(dto.getId()==null && CollectionUtils.isEmpty(dto.getIds())){
		  throw new DocException("没有查询主键"+JSON.toJSONString(dto));
		 }
		 
		return this.getSqlMapClientTemplate().update("${tableName}.update${javaName}ByIds", dto);
	}
	
	
	/**
    * 获取下一个seq key 主键id
    */
    public Long getNextSeqValue(){
       try {
            return this.seq${javaName}.nextValue();
        } catch (SequenceException e) {
            throw new DocException(e.getMessage(),e);
        }
    }
	
	
}