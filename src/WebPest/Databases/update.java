package WebPest.Databases;

import java.sql.*;
import java.util.Date;

public class update {
    public String Adcomment(int rTid,String email,int rUid, String text) {//根据索引取某一条数据
        try {
            // 获取数据库的连接
            Connection conn = dataInitDAO.getConnection();
            String sql = "INSERT INTO webreply VALUES(NULL,?,?,NULL,?,?,1)";
            // 预处理sql语句
            PreparedStatement presta = conn.prepareStatement(sql);
            // 设置sql语句中的values值
            presta.setInt(1, rTid);
            presta.setInt(2, rUid);
            presta.setString(3, text);
            Date date = new Date();
            presta.setTimestamp(4,new Timestamp(date.getTime()+8*3600*1000));
            // 执行SQL语句，实现数据添加
            presta.execute();
            searchAccountDAO account=new searchAccountDAO();
            ResultSet rs=account.searchUID(email);
            String head=rs.getString("UHead");
            String name=rs.getString("UName");
            dataInitDAO.closeBoth(conn,presta);
            String re="<li class=\"comment-item\">\n" +
                    "\t\t\t\t\t\t\t<div class=\"post__author author vcard inline-items\">\n" +
                    "\t\t\t\t\t\t\t\t<img src=\""+head+"\" alt=\"author\">\n" +
                    "\t\t\t\t\t\n" +
                    "\t\t\t\t\t\t\t\t<div class=\"author-date\">\n" +
                    "\t\t\t\t\t\t\t\t\t<a class=\"h6 post__author-name fn\" href=\"#\">"+name+"</a>\n" +
                    "\t\t\t\t\t\t\t\t\t<div class=\"post__date\">\n" +
                    "\t\t\t\t\t\t\t\t\t\t<time class=\"published\" datetime=\"2017-03-24T18:18\">\n" +
                    "\t\t\t\t\t\t\t\t\t\t\t0 mins ago\n" +
                    "\t\t\t\t\t\t\t\t\t\t</time>\n" +
                    "\t\t\t\t\t\t\t\t\t</div>\n" +
                    "\t\t\t\t\t\t\t\t</div>\n" +
                    "\t\t\t\t\t\n" +
                    "\t\t\t\t\t\t\t\t<a href=\"#\" class=\"more\">\n" +
                    "\t\t\t\t\t\t\t\t\t<svg class=\"olymp-three-dots-icon\">\n" +
                    "\t\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-three-dots-icon\"></use>\n" +
                    "\t\t\t\t\t\t\t\t\t</svg>\n" +
                    "\t\t\t\t\t\t\t\t</a>\n" +
                    "\t\t\t\t\t\n" +
                    "\t\t\t\t\t\t\t</div>\n" +
                    "\t\t\t\t\t\n" +
                    "\t\t\t\t\t\t\t<p>"+text+"</p>\n" +
                    "\t\t\t\t\t\n" +
                    "\t\t\t\t\t\t\t<a href=\"#\" class=\"post-add-icon inline-items\">\n" +
                    "\t\t\t\t\t\t\t\t<svg class=\"olymp-heart-icon\">\n" +
                    "\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-heart-icon\"></use>\n" +
                    "\t\t\t\t\t\t\t\t</svg>\n" +
                    "\t\t\t\t\t\t\t\t<span>0</span>\n" +
                    "\t\t\t\t\t\t\t</a>\n" +
                    "\t\t\t\t\t\t\t<a href=\"#\" class=\"reply\">Reply</a>\n" +
                    "\t\t\t\t\t\t</li>";
            replyaddnum(rTid);
            return re;
        } catch (SQLException e) {
            e.printStackTrace();
        }
return null;
    }

    public void replyaddnum(int Tid){
        try {
            Connection conn = dataInitDAO.getConnection();
            String sql = "UPDATE webtopic SET TReplyCount=TReplyCount+1 where TID="+Tid;
            PreparedStatement presta = conn.prepareStatement(sql);
            presta.execute();

        }catch (SQLException e){e.printStackTrace();}

    }
    public void clickaddnum(int Tid){
        try {
            Connection conn = dataInitDAO.getConnection();
            String sql = "UPDATE webtopic SET TClickCoount=TClickCoount+1 where TID="+Tid;
            PreparedStatement presta = conn.prepareStatement(sql);
            presta.execute();

        }catch (SQLException e){e.printStackTrace();}

    }




}



