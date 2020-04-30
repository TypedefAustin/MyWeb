package WebPest.Databases;
import java.sql.*;
import java.sql.SQLException;
import java.util.ArrayList;

public class infomationBaseDAO {

    public static void main(String[] args) {

            infomationBaseDAO inf =new infomationBaseDAO();
        ArrayList <String> a =new ArrayList<>();
           a= inf.WebInf("1175721708@qq.com");
        ArrayList <String> b=inf.StuInf(a.get(0));
        String aa= b.get(1);
    }


    public ArrayList<String>  WebInf(String User) {
        //连接数据库
        Connection conn = dataInitDAO.getConnection();
        String sql="SELECT * FROM webuser WHERE Uemail="+"'"+ User+"'";
        try {
            PreparedStatement pre=conn.prepareStatement(sql);
            ResultSet rs=pre.executeQuery();
            ArrayList <String> web_inf =new ArrayList<>();

            while(rs.next()){
                web_inf.add(rs.getString("UStucard"));//校园卡ID0
                web_inf.add(rs.getString("Uname"));//昵称1
                web_inf.add(rs.getString("UEmail"));//邮箱2
                web_inf.add(rs.getString("UPassword"));//密码3
                web_inf.add(rs.getString("UBirthday"));//日期4
                web_inf.add(rs.getString("UID"));//5
                web_inf.add(rs.getString("UHead"));//日期6
                web_inf.add(rs.getString("UStatement"));//状态7
                return  web_inf;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public ArrayList<String> StuInf(String User) {
        //连接数据库
        Connection conn = dataInitDAO.getConnection();
        String sql="SELECT * FROM stu_info WHERE stu_id="+"'"+ User+"'";
        try {
            PreparedStatement pre=conn.prepareStatement(sql);
            ResultSet rs=pre.executeQuery();
            ArrayList <String> stu_inf =new ArrayList<>();

            while(rs.next()){
                stu_inf.add(rs.getString(1));
                stu_inf.add(rs.getString(2));
                stu_inf.add(rs.getString(3));
                return  stu_inf;
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

}