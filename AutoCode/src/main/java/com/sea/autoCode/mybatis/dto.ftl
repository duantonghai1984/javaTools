package ${dtoPackageName};

import java.util.List;
import java.util.Date;


import com.angel.dmds.common.mybatis.BaseDto;
import com.angel.dmds.common.mybatis.PgDto;
import ${moPackageName}.${javaName};



/**
    对应数据表  ${tableName} 的数据库操作接口
**/

public class ${dtoName} extends ${javaName} implements PgDto{

private static final long serialVersionUID = 1L;


	private BaseDto pg = new BaseDto();

	
	public BaseDto getPg() {
		if (pg == null) {
			pg = new BaseDto();
		}
		return pg;
	}	

    
	public void setLimit(int limit){
		this.getPg().setLimit(limit);
	}

	public void setStart(int start){
		this.getPg().setStart(start);
	}
   
}