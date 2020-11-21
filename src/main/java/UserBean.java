import java.sql.*;

public class UserBean {
    private Connection conn;
    private PreparedStatement pstmt;
    private ResultSet rs;

    public UserBean() throws SQLException, ClassNotFoundException {
        String dbURL = "jdbc:mysql://localhost:52600/BBS?serverTimezone=UTC";
        String dbID = "jsp";
        String dbPassword = "86528652";
        String jdbc_driver = "com.mysql.jdbc.Driver";
        Class.forName(jdbc_driver);
        conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
    }
}
