package WebPest.Databases;
import java.sql.*;
import java.util.Date;

public class savaDataDAO {

   public static void main(String[] args){
       savaDataDAO sdata=new savaDataDAO();
      sdata.SavePost("1175721708@qq.com","hahahaha","null");

   }
    public boolean RegistStuInfo(String id1, String name1,String psw1) {
        // TODO Auto-generated method stub
        dataInitDAO init=new dataInitDAO();
        Connection conn = init.getConnection();
        String sql="insert into stu_info values(?,?,?)";
        try {
            PreparedStatement pre=conn.prepareStatement(sql);
            pre.setString(1, id1);
            pre.setString(2, name1);
            pre.setString(3,psw1);
            pre.executeUpdate();
                init.closeBoth(conn,pre);
            return true;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    public boolean RegistWebInfo(String id1, String name1,String psw1,String email1,String date1) {
        // TODO Auto-generated method stub
        dataInitDAO init=new dataInitDAO();
        Connection conn =init.getConnection();
        String sql="insert into webuser values(null,?,?,?,?,?,?,null,?)";
        try {
            PreparedStatement pre=conn.prepareStatement(sql);
            pre.setString(1,email1);
            pre.setString(2,name1);
            pre.setString(3,psw1);
            pre.setString(4,date1);
            pre.setString(5,id1);
            pre.setString(6," img/author-page.jpg");
            java.util.Date date = new Date();
            pre.setTimestamp(7,new Timestamp(date.getTime()+8*3600*1000));
            pre.executeUpdate();
            init.closeBoth(conn,pre);
            return true;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }


    public boolean SavePost(String email, String comment,String pic) {
        // TODO Auto-generated method stub
        dataInitDAO init=new dataInitDAO();
        Connection conn =init.getConnection();
        String sql="insert into webtopic values(?,?,?,?,?,?,?,?,1,null,null,null)";
        try {
            PreparedStatement pre=conn.prepareStatement(sql);
           searchAccountDAO ct=new searchAccountDAO();
            ResultSet trs =ct.searchUID(email);
            if(trs==null)
                return false;
            pre.setString(1,null);//主键
            pre.setInt(2, trs.getInt("Uid"));//主键UID
            pre.setInt(3,0);//回复数
            pre.setString(4,pic);                                     //图片
            pre.setString(5,comment);//发帖内容
            pre.setTimestamp(6,new Timestamp(System.currentTimeMillis()+8*3600000));//现在时间7
            pre.setInt(7,0);//点赞次数
            pre.setInt(8,0);//转发数
            pre.executeUpdate();
            init.closeBoth(conn,pre);
            return true;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }

    public boolean saveForums(String email, String comment,String topic) {
        // TODO Auto-generated method stub
        dataInitDAO init=new dataInitDAO();
        Connection conn =init.getConnection();
        String sql="insert into webtopic values(?,?,?,?,?,?,?,?,2,?,null,null)";
        try {
            PreparedStatement pre=conn.prepareStatement(sql);
            searchAccountDAO ct=new searchAccountDAO();
            ResultSet trs =ct.searchUID(email);
            if(trs==null)
                return false;
            pre.setString(1,null);//主键
            pre.setInt(2, trs.getInt("Uid"));//主键UID
            pre.setInt(3,0);//回复数
            pre.setString(4,null);                                     //图片
            pre.setString(5,comment);//发帖内容
            pre.setTimestamp(6,new Timestamp(System.currentTimeMillis()+8*3600000));//现在时间7
            pre.setInt(7,0);//点赞次数
            pre.setInt(8,0);//转发数
            pre.setString(9,topic);//主题
            pre.executeUpdate();
            init.closeBoth(conn,pre);
            return true;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return false;
    }



}




