package com.sea.autoCode.devCode;

import java.io.File;
import java.net.URL;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.sea.autoCode.BaseCodeCreator;
import com.sea.autoCode.config.Config;
import com.sea.autoCode.devCode.vo.Cloumn;
import com.sea.autoCode.util.DatabaseHelpler;

public class MutilCodeCreator extends BaseCodeCreator {

	private Map<String, List<Cloumn>> tableColumnsMap = new HashMap<String, List<Cloumn>>();

	private Map<String, String> tableJavaMap = new HashMap<String, String>();

	public MutilCodeCreator(Connection connection) {
		String[] tables = config.get().get("tableNames").split(",");
		String[] javas = config.get().get("javaNames").split(",");
		if (tables.length != javas.length || tables.length < 1) {
			throw new RuntimeException("表和java对象不匹配");
		}

		for (int i = 0; i < tables.length; i++) {
			tableJavaMap.put(tables[i], javas[i]);
		}

		extractColumnsInfo(connection, tables);

	}

	private void extractColumnsInfo(Connection connection, String[] tables) {

		try {
			if (connection == null || connection.isClosed()) {
				throw new RuntimeException("null db connection");
			}

			for (String str : tables) {
				List<Cloumn> cloumns = DatabaseHelpler.getColumns(connection, str);
				System.out.println("cloumns:" + cloumns.size());
				tableColumnsMap.put(str, cloumns);
			}

		} catch (Exception e) {
			e.printStackTrace();

		} finally {
			try {
				connection.close();
			} catch (SQLException e) {
				throw new RuntimeException(e.getMessage(), e);
			}
		}
	}

	@Override
	protected Config createConfig() {
		Config config = new Config("/com/autoCode/config/devConfg.properties");
		return config;
	}

	private void mutilCreateCodeFile(FileNameCreator codeCreator, String templateName) {
		Iterator<String> iterator = this.tableColumnsMap.keySet().iterator();
		while (iterator.hasNext()) {
			String tableName = iterator.next();
			Map<String, Object> root = new HashMap<String, Object>();
			root.putAll(config.get());
			root.remove("tableName");
			root.remove("javaName");
			root.put("tableName", tableName);
			root.put("javaName", tableJavaMap.get(tableName));
			root.put("columns", tableColumnsMap.get(tableName));
			// if(tableName.equals ("AP_NEW_PAY_PLAN_TOP")){
			List<Cloumn> cos = tableColumnsMap.get(tableName);
			for (Cloumn col : cos) {
				System.out.println(col.toString());
			}
			// }

			root.put("moName", root.get("javaName"));
			root.put("dtoName", root.get("javaName") + "Dto");
			root.put("daoName", root.get("javaName") + "Dao");
			root.put("daoImplName", root.get("javaName") + "DaoImpl");
			root.put("serviceName", root.get("javaName") + "Service");
			root.put("serviceImplName", root.get("javaName") + "ServiceImpl");

			String[] javas = config.get().get("javaNames").split(",");
			String[] tables = config.get().get("tableNames").split(",");
			root.put("javas", javas);
			root.put("tables", tables);

			createCodeByTemplate(root, templateName, codeCreator.getFileName(tableName, tableJavaMap.get(tableName)));
		}

	}

	interface FileNameCreator {
		public String getFileName(String tableName, String javaName);
	};

	public void createIbatis() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				return "sqlmap-" + javaName.substring(0, 1).toLowerCase() + javaName.substring(1) + ".xml";
			}

		}, "ibatis.ftl");
	}

	public void createMybatis() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				return javaName + "Mapper.xml";
			}

		}, "mybatis.ftl");
	}

	public void createJavaMo() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				String filePath = javaName + ".java";
				return getFinalFilePath(filePath, config.get("moPackageName"));
			}

		}, "mo.ftl");

	}

	public void createJavaDto() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				String filePath = javaName + "Dto.java";
				return getFinalFilePath(filePath, config.get("dtoPackageName"));
			}

		}, "dto.ftl");
	}

	public void createJavaDao() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				String filePath = javaName + "Mapper.java";
				return getFinalFilePath(filePath, config.get("daoPackage"));
			}

		}, "dao.ftl");
	}

	public void createDaoTest() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				String filePath = javaName + "DaoTest.java";
				return getFinalFilePath(filePath, config.get("daoPackage"));
			}

		}, "daoTest.ftl");
	}

	public void createServiceTest() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				String filePath = javaName + "ServiceTest.java";
				return getFinalFilePath(filePath, config.get("servicePackage"));
			}

		}, "serviceTest.ftl");
	}

	public void createJavaDaoImpl() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				String filePath = javaName + "DaoImpl.java";
				return getFinalFilePath(filePath, config.get("daoImplPackage"));
			}

		}, "daoImpl.ftl");
	}

	public void createJavaService() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				String filePath = javaName + "Service.java";
				return getFinalFilePath(filePath, config.get("servicePackage"));
			}

		}, "service.ftl");

	}

	public void createJavaServiceImpl() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				String filePath = javaName + "ServiceImpl.java";
				return getFinalFilePath(filePath, config.get("serviceImplPackage"));
			}

		}, "serviceImpl.ftl");
	}

	public void createTestData() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				return tableName.toLowerCase() + ".xml";
			}

		}, "test_data.ftl");
	}

	public void createSpringDaoConfig(String packName) {
		Map<String, Object> root = new HashMap<String, Object>();
		root.putAll(config.get());
		String[] javas = config.get().get("javaNames").split(",");
		root.put("javas", javas);
		createCodeByTemplate(root, "spring-dao.ftl", "spring-dao-" + packName + ".xml");
	}

	public void createSpringServiceConfig(String packName) {
		Map<String, Object> root = new HashMap<String, Object>();
		root.putAll(config.get());
		String[] javas = config.get().get("javaNames").split(",");
		root.put("javas", javas);
		createCodeByTemplate(root, "spring-service.ftl", "spring-service-" + packName + ".xml");

	}

	public void createConfigXml() {
		this.mutilCreateCodeFile(new FileNameCreator() {
			public String getFileName(String tableName, String javaName) {
				return "config.xml";
			}

		}, "spring-config.ftl");
	}

	public static void main(String[] args) throws SQLException {

		Connection con = null;
		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			con = DriverManager.getConnection("jdbc:mysql://localhost:3306/food", "root", "root");
		} catch (Exception e) {
			e.printStackTrace();
		}
		MutilCodeCreator autoCode = new MutilCodeCreator(con);

		URL url = MutilCodeCreator.class.getResource("/com/autoCode/mybatis/dao.ftl");
		File templateDir = new File(url.getFile());
		autoCode.setTemplateDir(templateDir);

		autoCode.createJavaMo();
		autoCode.createMybatis();
		autoCode.createIbatis ();
		autoCode.createJavaDto();
		autoCode.createJavaDao();
		 autoCode.createJavaDaoImpl ();
		

		autoCode.createJavaService();
		autoCode.createJavaServiceImpl();

		 autoCode.createServiceTest ();
		 autoCode.createDaoTest ();
		 autoCode.createTestData ();
		 autoCode.createSpringDaoConfig ("advertise");
		 autoCode.createConfigXml ();
		 autoCode.createTestData ();
		System.exit(1);
	}
}
