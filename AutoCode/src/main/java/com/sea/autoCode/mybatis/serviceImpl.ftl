package ${serviceImplPackage};

import java.util.ArrayList;
import java.util.List;
import com.angel.dmds.common.mybatis.Pagination;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import org.springframework.beans.BeanUtils;
import ${dtoPackageName}.${dtoName};
import ${moPackageName}.${javaName};
import ${servicePackage}.${serviceName};
import ${daoPackage}.${moName}Mapper;

@Service("${serviceName?uncap_first}")
public class ${serviceImplName} implements ${serviceName}{

	 @Resource
     private ${moName}Mapper  ${(moName) ? uncap_first}Mapper;
     
     
	/**
	 * 分页查询
	 * @param dto
	 * @return
	 */
	public Pagination<${dtoName}> find${javaName}Pg(${dtoName} dto){
	
	  	Pagination<${dtoName}> pg = new Pagination<${dtoName}> ();
        int totalCount = this.${(moName) ? uncap_first}Mapper.count${javaName}(dto);

        dto.getPg ().setTotalCount (totalCount);
        dto.getPg ().calStart ();
        if(totalCount>0){
	        List<${dtoName}> rstList =  this.${(moName) ? uncap_first}Mapper.find${javaName}List(dto);
	        BeanUtils.copyProperties (dto.getPg (),pg);	        
	        pg.setResultList (rstList);
        }else{
        	pg.setResultList(new ArrayList<${dtoName}>());
        }
        pg.setTotalCount (totalCount);
        return pg;
	}
	
	/**
	 * 查询
	 * @param dto
	 * @return
	 */
	public List<${dtoName}> find${javaName}List(${dtoName} dto){
		return this.${(moName) ? uncap_first}Mapper.find${javaName}List(dto);
	}
	
	
	/**
	 * 根据Id查询
	 * @param id
	 * @return
	 */
	public ${dtoName} get${javaName}(Long id){
	   ${dtoName} dto = new ${dtoName}();
		dto.setId(id);
		List<${dtoName}> list = ${(moName) ? uncap_first}Mapper.find${javaName}List(dto);
		if(list==null || list.size()==0){
			return null;
		}
	  	return list.get(0);
	}
	
	
	/**
	 * 插入数据
	 * @param dto
	 * @return
	 */
	public Long create${javaName}(${moName} ${(moName) ? uncap_first}){
		${(moName) ? uncap_first}.setDefalutValue();
		return ${(moName) ? uncap_first}Mapper.insert${javaName}(${(moName) ? uncap_first});
	}
	
	/**
	 * 更新数据
	 * @param dto
	 * @return
	 */
	public int update${javaName}(${javaName} ${(moName) ? uncap_first}) {
		return this.${(moName) ? uncap_first}Mapper.update${javaName}ByIds(${(moName) ? uncap_first});
	}
	
	
	/**
	 * 删除数据
	 * @param ids
	 * @return
	 */
    public int delete${javaName}ByIds(List<Long> ids){
    	return this.${(moName) ? uncap_first}Mapper.delete${javaName}ByIds(ids);
    }
    
    /**
	 * 删除数据，id
	 * @param id
	 * @return
	 */
    public int delete${javaName}ById(Long id){
    	return this.${(moName) ? uncap_first}Mapper.delete${javaName}ById(id);
    }	
}