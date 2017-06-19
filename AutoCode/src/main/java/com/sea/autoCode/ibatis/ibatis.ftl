<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE sqlMap PUBLIC "-//ibatis.apache.org//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd">
<sqlMap namespace="${(ibatis_name_space)!''}">
	
   <typeAlias alias="${(moName) ? uncap_first}"  type="${moPackageName}.${moName}" />
   <typeAlias alias="${(dtoName) ? uncap_first}"  type="${dtoPackageName}.${dtoName}" />
  	
  	<resultMap id="${(moName) ? uncap_first}Map" class="${(dtoName) ? uncap_first}">
	    <#if columns??>
	           <#list columns as template>
	            <result column="${template.columnName}" property="${template.javaAtrName}"></result>
	           </#list>
		</#if>
	</resultMap>
	
	
	<sql id="${javaName}_fr">
  	   FROM ${tableName} t 
  	</sql>
  	
  	<sql id="${javaName}_fs">
  	    <#if columns??>
	           <#list columns as template>
	             t.${template.columnName},
	           </#list>
		</#if>
  	</sql>
  	
  	<sql id="${javaName}_where">
	    <dynamic prepend="where">
	     <#if columns??>
	           <#list columns as template>
	              <#if template.javaType.simpleName =='Date' >
	  			   <isNotEmpty prepend="and" property="${template.javaAtrName}Start">
			          <![CDATA[   
					      t.${template.columnName} >= to_date(#${template.javaAtrName}Start#, 'yyyy-MM-dd HH24:mi:ss')
				      ]]>
			         </isNotEmpty> 
			         
			        <isNotEmpty prepend="and" property="${template.javaAtrName}End">
			          <![CDATA[   
					      t.${template.columnName} <= to_date(#${template.javaAtrName}End#||' 23:59:59', 'yyyy-MM-dd HH24:mi:ss')
				      ]]>
			         </isNotEmpty> 
			         
	  			  <#else>
	  			   <isNotEmpty prepend="and" property="${template.javaAtrName}">
	  				t.${template.columnName} = #${template.javaAtrName}#
	  			   </isNotEmpty>
	  			   
	              </#if>
	           </#list>
		</#if>
		</dynamic>
    </sql>
    
    <sql id="${javaName}_order">
       <isNotEmpty prepend=" order by " property="pg.sort">
			$pg.sort$
			<isNotEmpty prepend="" property="pg.dir">
				$pg.dir$
			</isNotEmpty>
		</isNotEmpty>

		<isEmpty property="pg.sort">
			order by t.create_date desc
		</isEmpty>
    </sql>
    
    <sql id="${javaName}_fr_wh">
		<include refid="${javaName}_fr" />
		<include refid="${javaName}_where" />
		<include refid="${javaName}_order" />
	</sql>
	
	 <!--  分页查询 -->
     <select id="find${javaName}Pg"  resultMap="${(moName) ? uncap_first}Map"  parameterClass="${(dtoName) ? uncap_first}">
       select  <include refid="${javaName}_fs" /><include refid="${javaName}_fr" /> where t.rowid in(
			 select rid from (
			 select rownum rn,rid from(
			    select t.rowid rid,t.create_time  <include refid="${javaName}_fr_wh" />
			    )where rownum<![CDATA[ < ]]> #pg.end#
			) where rn<![CDATA[ >= ]]> #pg.start#
		) 
		<include refid="${javaName}_order" />
     </select>
     
     <select id="countFind${javaName}Pg"  resultClass="java.lang.Integer"  parameterClass="${(dtoName) ? uncap_first}">
        select count(rid) PG_TOTALCOUNT from
		      (
			    select rowid rid <include refid="${javaName}_fr_wh" />
			  ) 
     </select>
     
     
     <!--  插入数据 -->
     <insert id="insert${javaName}" parameterClass="${(moName) ? uncap_first}">
			<selectKey resultClass="java.lang.Long" keyProperty="id" type="pre">
	           select SEQ_${tableName}_ID.NEXTVAL from DUAL
	   	     </selectKey>
	   	     INSERT INTO  ${tableName}(
	   	      <#if columns??>
	           <#list columns as template>
				     ${template.columnName},
	           </#list>
			  </#if>
			  )
			  values
			  (
			  <#if columns??>
	           <#list columns as template>
				      #${template.javaAtrName}#,
	           </#list>
			  </#if>
			  )
	</insert>
	
		
     <update id="update${javaName}" parameterClass="${(dtoName) ? uncap_first}">
	   update  ${tableName} t
	  set 
	    <#if columns??>
	           <#list columns as template>
	  			   <isNotEmpty prepend="," property="${template.javaAtrName}">
	  				t.${template.columnName} = #${template.javaAtrName}#
	  			   </isNotEmpty>
	           </#list>
		</#if>
	  
	  1=1
	  where t.id=#id#
	</update>
	
	
	<update id="delete${javaName}" parameterClass="java.lang.Long">
	
	</update>
    
</sqlMap>
