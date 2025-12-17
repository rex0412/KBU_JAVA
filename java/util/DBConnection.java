package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

	private static final String DRIVER = "oracle.jdbc.driver.OracleDriver";
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe";
	private static final String USER_ID = "dev";
	private static final String USER_PW = "1234";

	public static Connection getConnection() {
		Connection conn = null;
		try {
			Class.forName(DRIVER);

			conn = DriverManager.getConnection(URL, USER_ID, USER_PW);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("DB 연결 실패: " + e.getMessage());
		}
		return conn;
	}
}