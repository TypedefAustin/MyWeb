package WebPest.Databases;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
public class dataInitDAO {
    public static final String JDBC_DRIVER = "com.mysql.cj.jdbc.Driver";
    public static final String DB_URL = "jdbc:mysql://localhost:3306/test01?useSSL=false&serverTimezone=UTC";
    public static final String USER = "root";//数据库用户名
    public static final String PASS = "000000";//数据库密码

    public static Connection  getConnection()
    {
        Connection conn = null;

        try {

            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return conn;
    }
    public static void closeAll(Connection conn,PreparedStatement pre,ResultSet rs)
    {
        try {
            if(rs!=null)
            {
                rs.close();
            }
            if(pre!=null)
            {
                pre.close();
            }
            if(conn!=null)
            {
                conn.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static void closeBoth(Connection conn,PreparedStatement pre)
    {
        try {

            if(pre!=null)
            {
                pre.close();
            }
            if(conn!=null)
            {
                conn.close();
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}
