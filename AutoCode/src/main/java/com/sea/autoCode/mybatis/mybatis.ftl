<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="${daoPackage}.${javaName}Mapper">  	
  	
	<resultMap id="${(moName) ? uncap_first}Map" type="${dtoPackageName}.${dtoName}">
	    <#if columns??>
	           <#list columns as template>
		<result column="${template.columnName}" property="${template.javaAtrName}"></result>
	           </#list>
		</#if>
	</resultMap>
	
	
	<sql id="${javaName}_fr">
  	   FROM ${tableName?lower_case} t 
	</sql>
  	
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
		where 1=1
	     <#if columns??>
	           <#list columns as template>
	              <#if template.javaType.simpleName =='Date' >
		<!--
		<if test="${template.javaAtrName}Start != null">
			<![CDATA[   
				and t.${template.columnName} >= to_date(#${template.javaAtrName}Start#, 'yyyy-MM-dd HH24:mi:ss')      
			]]>
   		</if> 
		<if test="${template.javaAtrName}End != null">
			<![CDATA[   
				and t.${template.columnName} <= to_date(#${template.javaAtrName}End#||' 23:59:59', 'yyyy-MM-dd HH24:mi:ss')
			]]>
		</if>
		-->			         
	  			  <#else>
		<if test="${template.javaAtrName} != null">
			and t.${template.columnName} = '${r'${'}${template.javaAtrName}${r'}'}'
		</if>	  			   
	              </#if>
	           </#list>
		</#if>
		
		
    </sql>
    
	<sql id="${javaName}_order">
		<choose>
			<when test="pg.sort !=null">
				order by  ${r'${pg.sort}'}
				<if test="pg.dir != null">
					 ${r'${pg.dir}'}
				</if>
			</when>
			<otherwise>  
			    order by t.gmt_created desc
			</otherwise>  
		</choose>
	</sql>
    
	<sql id="${javaName}_fr_wh">
		<include refid="${javaName}_fr" />
		<include refid="${javaName}_where" />
		<include refid="${javaName}_order" />
	</sql>
	
	 <!--  分页查询 -->
     <select id="find${javaName}List"  resultMap="${(moName) ? uncap_first}Map"  parameterType="${dtoPackageName}.${dtoName}">
       select  <include refid="${javaName}_fs" />
               <include refid="${javaName}_fr_wh" /> 
       <if test="pg.notPage != null">
	       limit ${r'${pg.start}'},${r'${pg.limit}'}
	   </if>
     </select>
     
     <select id="count${javaName}"  resultType="java.lang.Integer"  parameterType="${dtoPackageName}.${dtoName}">
        select count(1) as PG_TOTALCOUNT from ${tableName?lower_case} t <include refid="${javaName}_where" />
		 
     </select>
     
     
     <!--  插入数据 -->
     <insert id="insert${javaName}" parameterType="${moPackageName}.${moName}">
   	     INSERT INTO  ${tableName?lower_case}
   	     <trim prefix="(" suffix=")" suffixOverrides=",">
   	      <#if columns??>
           <#list columns as template>
			     <if test="${template.javaAtrName}!=null">${template.columnName},</if>
           </#list>
		  </#if>
		 </trim>
		 <trim prefix=" values(" suffix=")" suffixOverrides=",">
		  <#if columns??>
           <#list columns as template>
			      <if test="${template.javaAtrName}!=null">
			      	  <#if template.javaType.simpleName == 'Date'>
			      		${r'#{'}${template.javaAtrName},jdbcType=TIMESTAMP${r'}'},
			      	  <#elseif template.javaType.simpleName == 'String'>
			      	  	'${r'${'}${template.javaAtrName}${r'}'}',
			      	  <#else>
			      	  	 ${r'${'}${template.javaAtrName}${r'}'},
			      	  </#if>
			      </if>
           </#list>
		  </#if>
		 </trim>
	</insert>
	
		
	<update id="update${javaName}ByIds" parameterType="${dtoPackageName}.${dtoName}">
		update  ${tableName?lower_case} t
			<trim prefix="set" suffixOverrides=",">	
	    <#if columns??>
	           <#list columns as template>	  	
	           	   <#if template.javaAtrName !='id'>		   
				<if test="${template.javaAtrName} != null">	  			   	  
						<#if template.javaType.simpleName == 'Date'>
					t.${template.columnName} = ${r'#{'}${template.javaAtrName},jdbcType=TIMESTAMP${r'}'},
			      	  	<#elseif template.javaType.simpleName == 'String'>
					t.${template.columnName} = '${r'${'}${template.javaAtrName}${r'}'}',
			      	 	 <#else>
					t.${template.columnName} =  ${r'${'}${template.javaAtrName}${r'}'},
			      	  	</#if>			      	  
				</if>
					</#if>
	           </#list>
		</#if>
			</trim>
		where 
	    <trim prefixOverrides="or">
		    <if test="id != null" > 
		    	or t.id = ${r'${id}'}
		    </if>	  
		    <if test="ids != null and ids.size>0" > 
		    	or t.id in
		    	<foreach item="item" index="index" collection="ids" open="(" separator="," close=")">  
				   	${r'${item}'}
				</foreach>
		    </if>
	    </trim>	
	</update>
	
	
	<delete id="delete${javaName}ById"  parameterType="Long">
	   delete from  ${tableName?lower_case} where id =  ${r'#{id, jdbcType=BIGINT}'}
	</delete>
	
	<delete id="delete${javaName}ByIds" parameterType="java.util.List">
	   delete from  ${tableName?lower_case} where id in
	   	<foreach item="item" index="index" collection="list" open="(" separator="," close=")">  
		   	${r'${item}'}
		</foreach>
	</delete>
    
</mapper>
