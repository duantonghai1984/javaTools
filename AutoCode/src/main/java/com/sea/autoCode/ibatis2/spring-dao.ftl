<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans-2.0.xsd">
	
	<#if javaNames??>
	<#list javas as template>
	   <bean id="${(template) ?  uncap_first}Dao" class="${daoImplPackage}.${template}DaoImpl" >
		<property name="sqlMapClient">
			<ref bean="sqlMapClient_backendFinance" />
		</property>	
	</bean>
	  
	</#list>
	</#if>
    
</beans>
