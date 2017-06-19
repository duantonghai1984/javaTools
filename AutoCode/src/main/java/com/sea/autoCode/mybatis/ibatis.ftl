<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE sqlMap PUBLIC "-//ibatis.apache.org//DTD SQL Map 2.0//EN" "http://ibatis.apache.org/dtd/sql-map-2.dtd">
<sqlMap namespace="${(tableName)!''}">
	
   <typeAlias alias="${(moName) ? uncap_first}"  type="${moPackageName}.${moName}" />
   <typeAlias alias="${(dtoName) ? uncap_first}"  type="${dtoPackageName}.${dtoName}" />
  	
  	<resultMap id="${(moName) ? uncap_first}Map" class="${(dtoName) ? uncap_first}">
	    <#if columns??>
	           <#list columns as template>
	            <result column="${template.columnName}" property="${template.javaAtrName}"></result>
	           </#list>
		</#if>
	</resultMap>
	
	
  	
  	<sql id="${javaName}_fs">
  	    <#if columns??>
	           <#list columns as template>
	           <#if !template_has_next>
	            t.${template.columnName}
	           <#else>
	            t.${template.columnName},
	           </#if>
	           </#list>
		</#if>
  	</sql>
  	
  	<sql id="${javaName}_where">
	    <dynamic prepend="where">
	     <#if columns??>
	           <#list columns as template>
	  			   <isNotEmpty prepend="and" property="${template.javaAtrName}">
	  				t.${template.columnName} = #${template.javaAtrName}#
	  			   </isNotEmpty>
	  			   
	           </#list>
	           
	            <isNotEmpty prepend="and" property="ids">
						<iterate open=" t.id in (" close=") " property="ids" conjunction=",">
							#ids[]#
						</iterate>
				</isNotEmpty>
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
			order by t.gmt_created desc
		</isEmpty>
    </sql>
    
    <sql id="${javaName}_fr_wh">
		FROM ${tableName} t 
		<include refid="${javaName}_where" />
		<include refid="${javaName}_order" />
	</sql>
	
     
       <!--  分页查询 -->
       <select id="find${javaName}Pg"  resultMap="${(moName) ? uncap_first}Map"  parameterClass="${(dtoName) ? uncap_first}">
			   select <include refid="${javaName}_fs" />
			   <include refid="${javaName}_fr_wh" />
			   <isNull property="pg.notPage">
			      limit #pg.start#,#pg.limit#
			   </isNull>
			   
				
     </select>
     
     <select id="countFind${javaName}Pg"  resultClass="java.lang.Integer"  parameterClass="${(dtoName) ? uncap_first}">
			    select count(1) as PG_TOTALCOUNT 
			    FROM ${tableName} t 
				<include refid="${javaName}_where" />
     </select>
     
     
     <!--  插入数据 -->
     <insert id="insert${javaName}" parameterClass="${(moName) ? uncap_first}">
	   	     INSERT INTO  ${tableName}
	   	     <dynamic prepend="(" >
	   	      <#if columns??>
	           <#list columns as template>
	              <isNotNull prepend="," property="${template.javaAtrName}">${template.columnName}</isNotNull>
	           </#list>
			  </#if>
			  )</dynamic>
			  values
			  <dynamic prepend="(" >
			  <#if columns??>
	           <#list columns as template>
	             <isNotNull prepend="," property="${template.javaAtrName}">#${template.javaAtrName}#</isNotNull>
	           </#list>
			  </#if>
			  )</dynamic>
	</insert>
	
	
	<update id="update${javaName}ByIds" parameterClass="${(dtoName) ? uncap_first}">
	   update  ${tableName} t
	   	<dynamic prepend="set">
	    <#if columns??>
	           <#list columns as template>
	              <#if  template.javaAtrName!='id'>
	  			   <isNotEmpty prepend="," property="${template.javaAtrName}" >
	  				t.${template.columnName} = #${template.javaAtrName}#
	  			   </isNotEmpty>
	  			  </#if>
	           </#list>
		</#if>
	    </dynamic>
	    
	    where  1!=1
	  
	    <isNotEmpty prepend="or" property="id">
	  				t.id = #id#
	  	</isNotEmpty>
	  
	    <isEmpty prepend="or" property="id">
			<iterate open=" t.id in (" close=") " property="ids" conjunction=",">
							#ids[]#
			</iterate>
		</isEmpty>
	</update>
	
	
    
</sqlMap>
