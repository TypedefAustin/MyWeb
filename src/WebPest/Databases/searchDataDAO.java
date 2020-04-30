package WebPest.Databases;

import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

public class searchDataDAO {
    private static final long ONE_MINUTE = 60000L;

    private static final long ONE_HOUR = 3600000L;

    private static final long ONE_DAY = 86400000L;

    private static final long ONE_WEEK = 604800000L;


    private static final String ONE_SECOND_AGO = "秒前";

    private static final String ONE_MINUTE_AGO = "分钟前";

    private static final String ONE_HOUR_AGO = "小时前";

    private static final String ONE_DAY_AGO = "天前";

    private static final String ONE_MONTH_AGO = "月前";

    private static final String ONE_YEAR_AGO = "年前";

    public static void main(String[] args) {
        searchDataDAO a = new searchDataDAO();
        String s = a.GetPost(1);
        System.out.println(s);

    }

    public String timeset(Timestamp time) {

        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:m:s");
        Date time1 = new Date(time.getTime());//java.util.Date
        return format(time1);
    }

    public void reflushpost() {
        try {
            Connection conn = dataInitDAO.getConnection();
            String tsql = "DROP  VIEW  IF  EXISTS  topicinfo";
            PreparedStatement stmt = conn.prepareStatement(tsql);
            if (stmt!=null) {
                stmt.execute();
                 stmt.close();
            }
            tsql = "create view topicinfo as select a.UEmail as Email, a.UName as Name, a.Uhead as Head, b.Tid as Tid, b.TPicture as picture,b.TSid as TSid, b.TTime as time, b.TClickCoount as ClickCount, b.TReplyCount as ReplyCount, b.TFlag as Flag, b.TContents as Contents from webuser as a, webtopic as b where a.uid=b.tuid;";
            stmt = conn.prepareStatement(tsql);
            stmt.execute();
            dataInitDAO.closeBoth(conn,stmt);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

    public void reflushcomment() {
        try {
            Connection conn = dataInitDAO.getConnection();
            String tsql = "DROP  VIEW  IF  EXISTS  replyinfo";
            PreparedStatement stmt = conn.prepareStatement(tsql);
            if (stmt!=null) {
                stmt.execute();
                stmt.close();
            }
            tsql = "create view replyinfo as select a.UEmail as Email, a.UName as Name, a.Uhead as Head,b.RID as RID, b.RTid as Tid, b.RUid as Uid,b.RSid as RSid, b.TEmotion as TEmotion ,b.RContent as Contents ,b.Rtime as time from webuser as a, webreply as b where a.uid=b.ruid";
            stmt = conn.prepareStatement(tsql);
            stmt.execute();
            dataInitDAO.closeBoth(conn,stmt);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
    public void reflushForums() {
        try {
            Connection conn = dataInitDAO.getConnection();
            String tsql = "DROP  VIEW  IF  EXISTS  replyinfo";
            PreparedStatement stmt = conn.prepareStatement(tsql);
            if (stmt!=null) {
                stmt.execute();
                stmt.close();
            }
            tsql = "create view replyinfo as select a.UEmail as Email, a.UName as Name, a.Uhead as Head,b.RID as RID, b.RTid as Tid, b.RUid as Uid,b.RSid as RSid, b.TEmotion as TEmotion ,b.RContent as Contents ,b.Rtime as time from webuser as a, webreply as b where a.uid=b.ruid";
            stmt = conn.prepareStatement(tsql);
            stmt.execute();
            dataInitDAO.closeBoth(conn,stmt);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }


    public String GetPost(int index) {//根据索引取某一条数据
        //连接数据库
        Connection conn = dataInitDAO.getConnection();
        String sql = "select * from topicinfo  where tsid=1 order by Tid desc limit " + ((index - 1) * 10) + "," + index * 10;
        try {
            reflushpost();
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            String Allpost = "";
            while (rs.next()) {
                String post = Onepost(rs.getString("Email"),
                        timeset(rs.getTimestamp("time")),
                        rs.getString("Name"),
                        rs.getString("Head"),
                        rs.getString("picture"),
                        rs.getString("contents"),
                        rs.getInt("Tid"),
                        rs.getInt("ReplyCount"),
                        rs.getInt("ClickCount"),
                        rs.getInt("Flag"));
                Allpost += post;
            }
            dataInitDAO.closeBoth(conn,pre);
            return Allpost;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public String GetSearchPost(String content, int index) {//根据索引取某一条数据
        //连接数据库
        Connection conn = dataInitDAO.getConnection();
        String sql = "select * from topicinfo where Contents like '%" + content + "%'"+"and Tsid=1"+" order by Tid desc limit " + 3 * index + "," + index + 3;
        try {
            reflushpost();
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            String Allpost = "";
            while (rs.next()) {
                String post = Onepost(rs.getString("Email"),
                        timeset(rs.getTimestamp("time")),
                        rs.getString("Name"),
                        rs.getString("Head"),
                        rs.getString("picture"),
                        rs.getString("contents"),
                        rs.getInt("Tid"),
                        rs.getInt("ReplyCount"),
                        rs.getInt("ClickCount"),
                        rs.getInt("Flag"));
                Allpost += post;
            }
            dataInitDAO.closeBoth(conn,pre);
            return Allpost;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public int GetSearchPostnum(String content) {//根据索引取某一条数据
        //连接数据库
        Connection conn = dataInitDAO.getConnection();
        String sql = "select count(*) from topicinfo where Contents like '%" + content + "%'"+"and Tsid=1";
        try {
            reflushpost();
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            int postnum = 0;
            while (rs.next()) {
                postnum = rs.getInt(1);
            }
            dataInitDAO.closeBoth(conn,pre);
            return postnum;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    public String GetSearchPonit(String content) {//根据索引取某一条数据
        int num=GetSearchPostnum(content);
        int pno = num / 3 + 1;
        String res = "";
        String ins = "";
        String head = "<nav aria-label=\"Page navigation\">\n" +
                "\t\t\t<ul class=\"pagination justify-content-center\">\n" +
                "\t\t\t\t<li class=\"page-item\">\n" +
                "<a class=\"page-link\" href=\"javascript:void(0)\" onclick=\"firstpage(this)\" tabindex=\"-1\">首页</a>" +
                "\t\t\t\t</li>\n" +
                "\t\t\t\t<li class=\"page-item\">"+"<a class=\"page-link\" href=\"javascript:void(0)\" onclick=\"Ajax01('08',this)\">"+"<div class=\"pageindex\">1</div>"+"<div class=\"ripple-container\"><div class=\"ripple ripple-on ripple-out\" style=\"left: -10.3833px; top: -16.8333px; background-color: rgb(255, 255, 255); transform: scale(16.7857);\"></div></div></a></li>";
        if (num>3)
            for (int i = 2; i <= pno; i++) {
                ins += "<li class=\"page-item\"><a class=\"page-link\" href=\"javascript:void(0)\" onclick=\"Ajax01('08',this)\">"+"<div class=\"pageindex\">"+pno+"</div>"+"</a></li>";
            }
        res = head + ins + "<a class=\"page-link\" href=\"javascript:void(0)\" onclick=\"nextpage(this)\">下一页</a>" +
                "\t\t\t\t</li>\n" +
                "\t\t\t</ul>\n" +
                "\t\t</nav>";
        return res;
    }

    public static String format(Date date) {

        long delta = new Date().getTime() - date.getTime();

        if (delta < 1L * ONE_MINUTE) {

            long seconds = toSeconds(delta);

            return (seconds <= 0 ? 1 : seconds) + ONE_SECOND_AGO;

        }

        if (delta < 45L * ONE_MINUTE) {

            long minutes = toMinutes(delta);

            return (minutes <= 0 ? 1 : minutes) + ONE_MINUTE_AGO;

        }

        if (delta < 24L * ONE_HOUR) {

            long hours = toHours(delta);

            return (hours <= 0 ? 1 : hours) + ONE_HOUR_AGO;

        }

        if (delta < 48L * ONE_HOUR) {

            return "昨天";

        }

        if (delta < 30L * ONE_DAY) {

            String times = date.toString();
            times.substring(6, 10);

        }

        if (delta < 12L * 4L * ONE_WEEK) {


            return date.toString();

        } else {

            long years = toYears(delta);

            return date.toString();

        }

    }


    private static long toSeconds(long date) {

        return date / 1000L;

    }


    private static long toMinutes(long date) {

        return toSeconds(date) / 60L;

    }


    private static long toHours(long date) {

        return toMinutes(date) / 60L;

    }


    private static long toDays(long date) {

        return toHours(date) / 24L;

    }


    private static long toMonths(long date) {

        return toDays(date) / 30L;

    }


    private static long toYears(long date) {

        return toMonths(date) / 365L;

    }

    public String getForums(int index) {//根据索引取某一条数据
        //连接数据库
        Connection conn = dataInitDAO.getConnection();
        String sql = "select * from webtopic where tsid=2 order by Tid desc limit " + ((index - 1) * 10) + "," + index * 10;
        try {
            reflushpost();
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs1 = pre.executeQuery();
            String Allpost = "";
            while (rs1.next()) {
                String topic=rs1.getString("TTopic");
                String uid=rs1.getString("tuid");
                int tid=rs1.getInt("TID");
                String ruid=rs1.getString("TTLastReplyUseID");
                String time=rs1.getString("TLastReplayTime");
                String aname=null;
                String rname=null;
                String ahead=null;
                String rhead=null;
                sql = "select * from webuser where uid= "+uid;
                pre = conn.prepareStatement(sql);
                ResultSet rs2 = pre.executeQuery();
                while (rs2.next())
                {
                 aname=rs2.getString("UName");
                 ahead=rs2.getString("UHead");
                }
                sql = "select * from webuser where uid= "+ruid;
                pre = conn.prepareStatement(sql);
                ResultSet rs3 = pre.executeQuery();
                while (rs3.next())
                {
                    rname=rs3.getString("UName");
                    rhead=rs3.getString("UHead");
                }

                String post = oneForums(aname,
                        topic,
                        ahead,
                        rhead,
                        tid,
                        rs1.getInt("TReplyCount"),
                        rname,
                        time);

                Allpost += post;
            }
            dataInitDAO.closeBoth(conn,pre);
            return Allpost;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }
    public String getForumsDetail(int tid) {//根据索引取某一条数据

        Connection conn = dataInitDAO.getConnection();
        String sql = "select * from replyinfo where rsid=2 and Tid="+tid+" order by rid desc";
        try {
            reflushpost();
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs1 = pre.executeQuery();
            String Allpost = "";
            while (rs1.next()) {
                String name=rs1.getString("name");
                String head=rs1.getString("Head");
                String content=rs1.getString("Contents");
                String time=rs1.getString("time");
                String post = listForums(name, head, content, time);
                Allpost += post;
            }
            dataInitDAO.closeBoth(conn,pre);
            return Allpost;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
        }

    public String listForums(String name, String head, String content,String time)
    {
        String res="\t<tr>\n" +
                "\t\t\t\t\t\t<td class=\"topic-date\" colspan=\"2\">\n" +
                "\t\t\t\t\t\t\t"+time+"\n" +
                "\t\t\t\t\t\t\t<a href=\"#\" class=\"reply-topic\">Reply</a>\n" +
                "\t\t\t\t\t\t</td>\n" +
                "\t\t\t\t\t</tr>\n" +
                "\t\t\t\t\n" +
                "\t\t\t\t\t<tr>\n" +
                "\t\t\t\t\t\t<td class=\"author\">\n" +
                "\t\t\t\t\t\t\t<div class=\"author-thumb\">\n" +
                "\t\t\t\t\t\t\t\t<img src=\""+head+"\" alt=\"author\">\n" +
                "\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\t\t<div class=\"author-content\">\n" +
                "\t\t\t\t\t\t\t\t<a href=\"02-ProfilePage.html\" class=\"h6 author-name\">"+name+"</a>\n" +
                "\t\t\t\t\t\t\t\t<div class=\"country\">江西, 九江</div>\n" +
                "\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\t</td>\n" +
                "\t\t\t\t\t\t<td class=\"posts\">\n" +
                "\t\t\t\t\t\t\t<p>"+content+
                "</p>\n" +
                "\t\t\t\t\t\t</td>\n" +
                "\t\t\t\t\t</tr>";
        return res;
    }


    //a     b         a         a          b       b         b
//帖子作者 帖子主题 帖子作者头像 帖子回复头像 回复数 最新评论时间  最新人名
    public String oneForums(String name, String topic, String authorHead,String replyHead, int Tid, int Reply, String lastReplytime, String  lastReplyName)
    {
    String res="<tr>\n" +
            "                        <td class=\"forum\">\n" +
            "                            <div class=\"forum-item\">\n" +
            "                                <div class=\"content\">\n" +
            "                                    <a href=\"javascript:void(0);\" onclick=\"forumsOpen(this)\" class=\"h6 title\">"+topic+"</a>\n" +"<div class=\"Tid\" style=\"display: none;\">" + Tid + "</div>"+
            "                                </div>\n" +
            "                                <div class=\"author-started\">\n" +
            "                                    <span>作者:</span>\n" +
            "                                    <div class=\"author-thumb\">\n" +
            "                                        <img src=\""+authorHead+"\" alt=\"author\">\n" +
            "                                    </div>\n" +
            "                                    <a href=\"#\" class=\"h6 title\">"+name+"</a>\n" +
            "                                </div>\n" +
            "                            </div>\n" +
            "                            <nav aria-label=\"Page navigation\">\n" +
            "                            </nav>\n" +
            "                        </td>\n" +
            "                        <td class=\"topics\">\n" +
            "\n" +
            "                        </td>\n" +
            "                        <td class=\"posts\">\n" +
            "                            <a href=\"#\" class=\"h6 count\">"+Reply+"</a>\n" +
            "                        </td>\n" +
            "                        <td class=\"freshness\">\n" +
            "                            <div class=\"author-freshness\">\n" +
            "                                <div class=\"author-thumb\">\n" +
            "                                    <img src=\""+replyHead+"\" alt=\"author\">\n" +
            "                                </div>\n" +
            "                                <a href=\"#\" class=\"h6 title\">"+lastReplyName+"</a>\n" +
            "                                <time class=\"entry-date updated\" datetime=\"2017-06-24T18:18\">"+lastReplytime+"</time>\n" +
            "                            </div>\n" +
            "                        </td>\n" +
            "                    </tr>";
       return res;
    }

    public String Onepost(String email, String leavetime, String TName, String THead, String TPicture, String TContents, int Tid, int TReply, int TClick, int TRound) {

        try {
            String part1 = posthead(TName, THead, TContents, leavetime);//文字
            String part2 = postpic(TPicture);//图片
            String part3 = "<ul class=\"comments-list\">\n";//主评论
            String part4 = postTail(TReply, TClick, TRound);//尾评论
            String post;
            if (TPicture != null) {
                post = part1 + part2 + part4;
            } else {
                post = part1 + part4;
            }
            reflushcomment();
            ResultSet RsReply = GetReply(Tid);
            if (TReply != 0) {
                int i = 0;
                while (RsReply != null && RsReply.next() && i < 2) {
                    i++;
                    part3 += comment(RsReply.getString("Contents"), timeset(RsReply.getTimestamp("time")), RsReply.getString("Head"), RsReply.getString("name"));

                }
                part3 += "</ul>";
                if (TReply > 2)
                    part3 += "<a href=\"javascript:void(0)\" onclick=\"Ajax01('04',this)\" class=\"more-comments\">View more comments <span>+</span></a>";
                post += part3;
                post += "<div class=\"Tid\" style=\"display: none;\">" + Tid + "</div>" + "</article>" +
                        "</div>";

            } else {
                post += "<div class=\"Tid\" style=\"display: none;\">" + Tid + "</div>" + "</article>" +
                        "</div>";
                //评论为0
            }
            return post;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String posthead(String name, String head, String text, String time) {
        String str = "<div class=\"ui-block\">\n" +
                "\t\t\t\t\t<!-- Post -->\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t<article class=\"hentry post has-post-thumbnail shared-photo\">\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t<div class=\"post__author author vcard inline-items\">\n" +
                "\t\t\t\t\t\t\t\t<img src=\"" + head + "\" alt=\"author\">\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<div class=\"author-date\">\n" +
                "\t\t\t\t\t\t\t\t\t<a class=\"h6 post__author-name fn\" href=\"02-ProfilePage.html\">" + name + "</a>" +
                "\t\t\t\t\t\t\t\t\t<div class=\"post__date\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<time class=\"published\" datetime=\"2017-03-24T18:18\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t" + time + "\n" +
                "\t\t\t\t\t\t\t\t\t\t</time>\n" +
                "\t\t\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<div class=\"more\">\n" +
                "\t\t\t\t\t\t\t\t\t<svg class=\"olymp-three-dots-icon\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-three-dots-icon\"></use>\n" +
                "\t\t\t\t\t\t\t\t\t</svg>\n" +
                "\t\t\t\t\t\t\t\t\t<ul class=\"more-dropdown\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<li>\n" +
                "<a href=\"javascript:void(0);\" onclick=\"Ajax01('06',this)\">删除</a>\n" +
                "\t\t\t\t\t\t\t\t\t\t</li>\n" +
                "\t\t\t\t\t\t\t\t\t</ul>\n" +
                "\t\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t<p>" + text + "</p>";

        return str;
    }

    public String postpic(String pic) {
        String str = "<ul class=\"widget w-last-photo js-zoom-gallery\" >\n" +
                "\t\t\t\t\t\t<li>\n" +
                "\t\t\t\t\t\t\t<a href=\"" + pic + "\">\n" +
                "\t\t\t\t\t\t\t\t<img src=\"" + pic + "\" alt=\"photo\">\n" +
                "\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\t</li>\n" +
                "\t\t\t\t\t</ul>";
        return str;
    }

    public String postTail(int reply, int click, int flag) {//缺一个/DIV 不需要补上


        String str = "<div class=\"post-additional-info inline-items\">\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<a href=\"#\" class=\"post-add-icon inline-items\">\n" +
                "\t\t\t\t\t\t\t\t\t<svg class=\"olymp-heart-icon\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-heart-icon\"></use>\n" +
                "\t\t\t\t\t\t\t\t\t</svg>\n" +
                "\t\t\t\t\t\t\t\t\t<span>" + click + "</span>\n" +
                "\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<ul class=\"friends-harmonic\">\n" +
                "\t\t\t\t\t\t\t\t\t<li>\n" +
                "\t\t\t\t\t\t\t\t\t\t<a href=\"#\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t<img src=\"img/friend-harmonic7.jpg\" alt=\"friend\">\n" +
                "\t\t\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\t\t\t\t</li>\n" +
                "\t\t\t\t\t\t\t\t\t<li>\n" +
                "\t\t\t\t\t\t\t\t\t\t<a href=\"#\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t<img src=\"img/friend-harmonic8.jpg\" alt=\"friend\">\n" +
                "\t\t\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\t\t\t\t</li>\n" +
                "\t\t\t\t\t\t\t\t\t<li>\n" +
                "\t\t\t\t\t\t\t\t\t\t<a href=\"#\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t<img src=\"img/friend-harmonic9.jpg\" alt=\"friend\">\n" +
                "\t\t\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\t\t\t\t</li>\n" +
                "\t\t\t\t\t\t\t\t\t<li>\n" +
                "\t\t\t\t\t\t\t\t\t\t<a href=\"#\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t<img src=\"img/friend-harmonic10.jpg\" alt=\"friend\">\n" +
                "\t\t\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\t\t\t\t</li>\n" +
                "\t\t\t\t\t\t\t\t\t<li>\n" +
                "\t\t\t\t\t\t\t\t\t\t<a href=\"#\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t<img src=\"img/friend-harmonic11.jpg\" alt=\"friend\">\n" +
                "\t\t\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\t\t\t\t</li>\n" +
                "\t\t\t\t\t\t\t\t</ul>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<div class=\"names-people-likes\">\n" +
                "\t\t\t\t\t\t\t\t\t<a href=\"#\">Jenny</a>, <a href=\"#\">Robert</a> and\n" +
                "\t\t\t\t\t\t\t\t\t<br>" + click + " more liked this\n" +
                "\t\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<div class=\"comments-shared\">\n" +
                "\t\t\t\t\t\t\t\t\t<a href=\"javascript:void(0);\" onclick=\"aclick(this)\" class=\"post-add-icon inline-items\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<svg class=\"olymp-speech-balloon-icon\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-speech-balloon-icon\"></use>\n" +
                "\t\t\t\t\t\t\t\t\t\t</svg>\n" +
                "\t\t\t\t\t\t\t\t\t\t<span>" + reply + "</span>\n" +
                "\t\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t\t<a href=\"#\" class=\"post-add-icon inline-items\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<svg class=\"olymp-share-icon\">\n" +
                "\t\t\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-share-icon\"></use>\n" +
                "\t\t\t\t\t\t\t\t\t\t</svg>\n" +
                "\t\t\t\t\t\t\t\t\t\t<span>" + flag + "</span>\n" +
                "\t\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t<div class=\"control-block-button post-control-button\">\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<a href=\"#\" class=\"btn btn-control featured-post\">\n" +
                "\t\t\t\t\t\t\t\t\t<svg class=\"olymp-trophy-icon\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-trophy-icon\"></use>\n" +
                "\t\t\t\t\t\t\t\t\t</svg>\n" +
                "\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<a href=\"#\" class=\"btn btn-control\">\n" +
                "\t\t\t\t\t\t\t\t\t<svg class=\"olymp-like-post-icon\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-like-post-icon\"></use>\n" +
                "\t\t\t\t\t\t\t\t\t</svg>\n" +
                "\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<a href=\"#\" class=\"btn btn-control\">\n" +
                "\t\t\t\t\t\t\t\t\t<svg class=\"olymp-comments-post-icon\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-comments-post-icon\"></use>\n" +
                "\t\t\t\t\t\t\t\t\t</svg>\n" +
                "\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t\t<a href=\"#\" class=\"btn btn-control\">\n" +
                "\t\t\t\t\t\t\t\t\t<svg class=\"olymp-share-icon\">\n" +
                "\t\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-share-icon\"></use>\n" +
                "\t\t\t\t\t\t\t\t\t</svg>\n" +
                "\t\t\t\t\t\t\t\t</a>\n" +
                "\t\t\t\t\t\n" +
                "\t\t\t\t\t\t\t</div>\n" +
                "\t\t\t\t\t\n";
//                "\t\t\t\t\t\t</article>";
        return str;

    }

    public String comment(String Tcomment, String time, String head, String name) {//记得加/ul
        String str =
                "\t\t\t\t\t\t<li class=\"comment-item\">\n" +
                        "\t\t\t\t\t\t\t<div class=\"post__author author vcard inline-items\">\n" +
                        "\t\t\t\t\t\t\t\t<img src=\"" + head + "\" alt=\"author\">\n" +
                        "\t\t\t\t\t\n" +
                        "\t\t\t\t\t\t\t\t<div class=\"author-date\">\n" +
                        "\t\t\t\t\t\t\t\t\t<a class=\"h6 post__author-name fn\" href=\"#\">" + name + "</a>\n" +
                        "\t\t\t\t\t\t\t\t\t<div class=\"post__date\">\n" +
                        "\t\t\t\t\t\t\t\t\t\t<time class=\"published\" datetime=\"2017-03-24T18:18\">\n" +
                        "\t\t\t\t\t\t\t\t\t\t\t" + time +
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
                        "\t\t\t\t\t\t\t<p>" + Tcomment + "</p>\n" +
                        "\t\t\t\t\t\n" +
                        "\t\t\t\t\t\t\t<a href=\"#\" class=\"post-add-icon inline-items\">\n" +
                        "\t\t\t\t\t\t\t\t<svg class=\"olymp-heart-icon\">\n" +
                        "\t\t\t\t\t\t\t\t\t<use xlink:href=\"svg-icons/sprites/icons.svg#olymp-heart-icon\"></use>\n" +
                        "\t\t\t\t\t\t\t\t</svg>\n" +
                        "\t\t\t\t\t\t\t\t<span>0</span>\n" +
                        "\t\t\t\t\t\t\t</a>\n" +
                        "\t\t\t\t\t\t\t<a href=\"#\" class=\"reply\">Reply</a>\n" +
                        "\t\t\t\t\t\t</li>";

        return str;
    }


        public ResultSet GetReply(int Tid) {//根据索引取某一条数据
        //连接数据库
        Connection conn = dataInitDAO.getConnection();
        String sql = "select * from replyinfo WHERE TID=" + Tid;
        try {
            PreparedStatement pre = conn.prepareStatement(sql);
            ResultSet rs = pre.executeQuery();
            return rs;

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }



}

