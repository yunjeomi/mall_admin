package gdu.mall.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBUtil {

	//공통으로 사용하는 db 핸들링 메소드화하여 코드 중복방지 
	//실행할 때 ManagerDao.getConnection();로 실행한다.
	//Manager 안 붙여야 하는 이유는? 없음. 붙여야 하는 이유는? dao 클래스 안에 있으니까
	public static Connection getConnection() throws Exception{
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://localhost:3306/mall", "root", "java1004");
		return conn;
	}
}
