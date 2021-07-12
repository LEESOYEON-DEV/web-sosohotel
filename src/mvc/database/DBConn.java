package mvc.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
	
	private static DBConn instance = new DBConn();
	
	// 생성자에 private 접근 제한자 (다른 곳에서 객체 생성 불가)
	private DBConn() {};
	
	public static Connection getConnection() throws SQLException, ClassNotFoundException {
		
		Connection conn = null;
		
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/sosohotel";
		String user = "root";
		String password = "mysql";
		
		Class.forName(driver);
		conn = DriverManager.getConnection(url, user, password);
		
		return conn;		
	}
}