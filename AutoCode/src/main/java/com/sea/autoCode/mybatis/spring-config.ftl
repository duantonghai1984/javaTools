<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:dwr="http://www.directwebremoting.org/schema/spring-dwr"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:aop="http://www.springframework.org/schema/aop"
	xmlns:util="http://www.springframework.org/schema/util"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.0.xsd
	http://www.springframework.org/schema/aop http://www.springframework.org/schema/aop/spring-aop-2.0.xsd
	http://www.directwebremoting.org/schema/spring-dwr http://www.directwebremoting.org/schema/spring-dwr-2.0.xsd
	http://www.springframework.org/schema/util http://www.springframework.org/schema/util/spring-util-2.0.xsd ">
	
	
	<#if javaNames??>
	<#list javas as template>
	
	 <bean id="${(template) ?  uncap_first}Service" class="${serviceImplPackage}.${template}ServiceImpl" autowire="byName">
	   </bean>
	</#list>
	</#if>
	
	

	
	
	<#if javaNames??>
	<#list javas as template>
	   <bean id="${(template) ?  uncap_first}Dao" class="${daoImplPackage}.${template}DaoImpl" >
			<property name="sqlMapClient">
			   <ref bean="sqlMapClient" />
			</property>
	</bean>
	  
	</#list>
	</#if>
	
	
	<#if javaNames??>
	<#list javas as template>
	  <bean id="seq${template}" class="com.taobao.tddl.client.sequence.impl.GroupSequence" init-method="init">
		<property name="sequenceDao" ref="idSequenceDao" />
		<!-- sequence -->
		<property name="name" value="seq_${tables[template_index]}" />
	</bean>
	  
	</#list>
	</#if>
    
</beans>
