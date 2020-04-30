package com.mrlin.Servlet;

import WebPest.Databases.*;
import WebPest.registGetTable;
import WebPest.getTodayWeather;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.*;


@WebServlet(name = "ajaxServlet")
public class ajaxServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=utf-8");
        String opr = request.getParameter("opr");
        update ud = new update();
        if (opr == null) //发帖
        {
            String realPath = "G:\\IDEA\\MyWeb\\web\\WebContent\\Temppic";
            String email = null;
            String text = null;
            String pic = null;
            try {
                request.setCharacterEncoding("utf-8");
                try {
                    DiskFileItemFactory factory = new DiskFileItemFactory();
                    ServletFileUpload upload = new ServletFileUpload(factory);
                    upload.setHeaderEncoding("UTF-8");
                    List items = upload.parseRequest(request);
                    Map params = new HashMap();
                    for (Object object : items) {
                        FileItem fileItem = (FileItem) object;
                        if (fileItem.isFormField()) {
                            params.put(fileItem.getFieldName(), fileItem.getString("utf-8"));//如果你页面编码是utf-8的
                        } else {
                            //如果fileitem中封装的是上传文件，得到上传的文件名称，
                            String fileName = fileItem.getName();//上传文件的名
                            //多个文件上传输入框有空 的 异常处理
                            if (fileName == null || "".equals(fileName.trim())) {  //去空格是否为空
                                continue;// 为空，跳过当次循环，  第一个没输入则跳过可以继续输入第二个
                            }

                            //处理上传文件的文件名的路径，截取字符串只保留文件名部分。//截取留最后一个"\"之后，+1截取向右移一位（"\a.txt"-->"a.txt"）
                            Connection conntemp = dataInitDAO.getConnection();
                            String sqltemp = "SELECT MAX(TID) FROM WEBTOPIC";
                            PreparedStatement pretemp = conntemp.prepareStatement(sqltemp);
                            ResultSet rstemp = pretemp.executeQuery();
                            int tidtemp = 0;
                            while (rstemp.next()) {
                                tidtemp = rstemp.getInt("MAX(TID)") + 1;
                            }
                            fileName = "img000000000" + tidtemp + ".jpg";
                            //拼接上传路径。存放路径+上传的文件名
                            String filePath = realPath + "\\" + fileName;
                            pic = "Temppic/" + fileName;
                            //构建输入输出流
                            InputStream in = fileItem.getInputStream(); //获取item中的上传文件的输入流
                            OutputStream out = new FileOutputStream(filePath); //创建一个文件输出流

                            //创建一个缓冲区
                            byte b[] = new byte[1024];
                            //判断输入流中的数据是否已经读完的标识
                            int len = -1;
                            //循环将输入流读入到缓冲区当中，(len=in.read(buffer))！=-1就表示in里面还有数据
                            while ((len = in.read(b)) != -1) {  //没数据了返回-1
                                //使用FileOutputStream输出流将缓冲区的数据写入到指定的目录(savePath+"\\"+filename)当中
                                out.write(b, 0, len);
                            }
                            out.close();
                            in.close();
                            //删除临时文件
                            try {
                                Thread.sleep(3000);
                            } catch (InterruptedException e) {
                                e.printStackTrace();
                            }
                            fileItem.delete();//删除处理文件上传时生成的临时文件
                            System.out.println("文件上传成功");
                        }
                    }


                    //使用params.get获取参数值
                    text = (String) params.get("text");
                    email = (String) params.get("email");
                    // 输出数据
                } catch (FileUploadException e1) {
                    e1.printStackTrace();
                }

                savaDataDAO save = new savaDataDAO();
                save.SavePost(email, text, pic);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }


        if (opr.equals("00")) //帖子
        {
            searchDataDAO search = new searchDataDAO();
            String str = search.GetPost(1);
            response.getWriter().write(str);
        }
        if (opr.equals("01")) //评论
        {
            int tid = Integer.parseInt(request.getParameter("Tid"));
            String text = request.getParameter("text");
            String email = request.getParameter("email");
            int Uid = Integer.parseInt(request.getParameter("Uid"));
            String str = ud.Adcomment(tid,email,Uid, text);
            ud.replyaddnum(tid);
            response.getWriter().write(str);
        }
        if (opr == "02") //点赞
        {
            int tid = Integer.parseInt(request.getParameter("Tid"));
            ud.clickaddnum(tid);
        }

        if (opr.equals("04"))//more
        {
            try {
                int tid = Integer.parseInt(request.getParameter("Tid"));
                Connection conn = dataInitDAO.getConnection();
                searchDataDAO more = new searchDataDAO();
                more.reflushcomment();
                String sql = "select * from replyinfo WHERE TID=" + tid+" and RSid=1";
                PreparedStatement pre = conn.prepareStatement(sql);
                ResultSet RsReply = pre.executeQuery();
                String res = "";
                RsReply.next();
                RsReply.next();
                while (RsReply.next()) {
                    res += more.comment(RsReply.getString("Contents"), more.timeset(RsReply.getTimestamp("time")), RsReply.getString("Head"), RsReply.getString("Name"));
                }
                response.getWriter().write(res);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        if (opr.equals("05"))//天气
        {
            getTodayWeather wea = new getTodayWeather();
            wea.Init();
            String week = wea.week;
            registGetTable table = new registGetTable();
            table.Start();
            ArrayList<registGetTable.Classinfo> Classtable = table.Classform;
            ArrayList<registGetTable.Classinfo> todayTable = new ArrayList<>();
            week = "周" + week.substring(2, 3);
            for (int i = 0; i < Classtable.size(); i++) {
                registGetTable.Classinfo temp = Classtable.get(i);
                if (temp.Week.contains(week)) {
                    todayTable.add(Classtable.get(i));
                }
            }
            for (int i = 0; i < todayTable.size(); i++) {
                for (int j = 0; j < todayTable.size(); j++) {
                    if (Integer.parseInt(todayTable.get(i).Week.substring(3, 4)) > Integer.parseInt(todayTable.get(j).Week.substring(3, 4)))
                        ;
                    Collections.swap(todayTable, i, j);
                }
            }
            String res = "";
            for (int i = 0; i < todayTable.size(); i++) {
                String str = "<li><h5 class=\"date\">" + todayTable.get(i).ClassName + "<br>" +
                        todayTable.get(i).ClassRoom + "<br>" +
                        todayTable.get(i).Week + "<br>" +
                        todayTable.get(i).Teacher + "</li>";
                res += str;
            }
            response.getWriter().write(res);
        }

        if (opr.equals("06"))//删除
        {
            try {
                int tid = Integer.parseInt(request.getParameter("Tid"));
                Connection conn = dataInitDAO.getConnection();
                String sql = "delete from webtopic WHERE TID="+tid;
                PreparedStatement pre = conn.prepareStatement(sql);
                pre.execute();
            } catch (Exception e)
            {
                e.printStackTrace();
            }
            response.getWriter().write("ok");
        }
        if (opr.equals("07"))//状态
        {
            try {
                String state = request.getParameter("state");
                String email = request.getParameter("email");
                searchAccountDAO account = new searchAccountDAO();
                account.changeState(email,state);
                PrintWriter pw=response.getWriter();
                response.getWriter().write(state);
            } catch (Exception e)
            {
                e.printStackTrace();
            }
        }
        if (opr.equals("08"))//分页
        {
            try {
                String content = request.getParameter("content");
                int index =Integer.valueOf(request.getParameter("index"));
                searchDataDAO data=new searchDataDAO();
              String  res=data.GetSearchPost(content,index-1);
                PrintWriter pw=response.getWriter();
                response.getWriter().write(res);
            } catch (Exception e)
            {
                e.printStackTrace();
            }
        }


    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
        request.setCharacterEncoding("utf-8");
    }
}
