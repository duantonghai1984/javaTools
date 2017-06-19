package ${daoPackage};


import com.yihaodian.backend.finance.service.dto.voucher.VoucherConfigInfoDto;
import com.yihaodian.backend.framework.common.ibatis.Pagination;
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
	public List<${dtoName}> find${javaName}List(${dtoName} dto,Integer ... max);
	
	
	
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
	
	
	
	public int update${javaName}(${moName} dto);
	
	
	/**
	 * 统计数目
	 * @param dto
	 * @return
	 */
	public int count${javaName}(${dtoName} dto);
	

}