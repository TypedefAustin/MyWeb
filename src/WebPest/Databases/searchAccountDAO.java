package WebPest.Databases;

import java.sql.*;
import java.sql.SQLException;

public class searchAccountDAO {
    private int UID;
    private String UEmail;
    private String UName;
    private String Uhead;
    private String Ubir;

    public int RUID() {
        return UID;
    }

    public String RUEmail() {
        return UEmail;
    }

    public String Rhead() {
        return Uhead;
    }

    public String Rname() {
        return UName;
    }

    public String RUbir() {
        return Ubir;
    }


    public boolean searchNameAndPwd(String loginemail, String loginPwd) {
        //连接数据库
        Connection conn = dataInitDAO.getConnection();
        String sql = "SELECT UEmail,UPassword FROM webuser WHERE UEmail=? AND UPassword=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, loginemail);
            pre.setString(2, loginPwd);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    public void changePsw(String email, String psw) {
        try {
            Connection conn = dataInitDAO.getConnection();
            PreparedStatement psql = conn.prepareStatement("update WEBUSER set UPassword = ? where UEmail = ?");
            psql.setString(1, psw);
            psql.setString(2, email);
            psql.executeUpdate();
            psql.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void changeState(String email,String state) {
        try {
            Connection conn = dataInitDAO.getConnection();
            PreparedStatement psql = conn.prepareStatement("update WEBUSER set UStatement = ? where UEmail = ?");
            psql.setString(1, state);
            psql.setString(2, email);
            psql.executeUpdate();
            psql.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }


    }

    public ResultSet searchUID(String email) {
        //连接数据库
        Connection conn = dataInitDAO.getConnection();
        String sql = "select * from webuser where UEmail=?";
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            pre.setString(1, email);
            ResultSet rs = pre.executeQuery();
            while (rs.next()) {
                UID = rs.getInt("UID");
                UEmail = rs.getString("UEmail");
                Uhead = rs.getString("UHead");
                UName = rs.getString("UName");
                Ubir = rs.getString("UBirthday");
                return rs;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }


}
