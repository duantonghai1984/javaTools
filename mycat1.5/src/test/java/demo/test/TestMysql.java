package demo.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TestMysql {

	
		
		public static void main(String[] args) throws Exception {
			Connection connection = null;
			PreparedStatement ps = null;
			com.mysql.jdbc.Driver d;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				String url = "jdbc:mysql://127.0.0.1:8066/bill?useUnicode=true&characterEncoding=UTF-8";
				String user="admin";
				String password="123";
				String sql="select * from dicts";
				
//				String url = "jdbc:mysql://localhost:3306/dmds";
//				String user="root";
//				String password="root";
//				String sql="select * from dmds";
				
				try {
					connection = DriverManager.getConnection(url,user,password);
				} catch (SQLException e) {
					String msg="url:"+url + ",user:"+user + ",password:"+password;
						throw new Exception("数据库连接获取异常："+msg,e);
				}
				ps = connection.prepareStatement(sql);		

			} catch (Exception e) {
				throw new Exception(e.getMessage(),e);
			} finally{
				try {
					if(ps!=null){
						ps.close();
					}
					if(connection!=null){
						connection.close();
					}
				} catch (SQLException e) {
					throw new Exception(e.getMessage(),e);
				}
			}	
		}



}
