package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
    public static Connection getConnection() {
        Connection conn = null;

        for (int i = 0; i < 10; i++) {
            try {
                // https://endorphin0710.tistory.com/53
                // There is no need to load driver manually from JDBC API4.0
                // Class.forName("com.mysql.jdbc.Driver");

                String url = "jdbc:mysql://localhost:52602/jsp";
                String user = "kitsune";
                String password = "86528652";

                Class.forName("org.mariadb.jdbc.Driver");
                conn = DriverManager.getConnection(url, user, password);
                if (conn != null) break;
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
            }
        }

        return conn;
    }
}
