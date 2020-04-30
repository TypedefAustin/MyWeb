package com.mrlin.Servlet;
import WebPest.*;
import WebPest.Databases.savaDataDAO;
import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.text.MessageFormat;


public class registeServlet extends HttpServlet {
    public void service(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        System.out.println("调用SEV");
        String method = req.getMethod();
        if (method.equals("GET")) {
            System.out.println("Do Get 调用");
            this.doGet(req, resp);

        } else if (method.equals("POST")) {
            System.out.println("Do Post 调用");
            this.doPost(req, resp);

        } else if (method.equals("PUT")) {
            doPut(req, resp);
        } else if (method.equals("DELETE")) {
            doDelete(req, resp);
        } else if (method.equals("OPTIONS")) {
            doOptions(req, resp);
        } else {
            String errMsg = ("http.method_not_implemented");
            Object[] errArgs = new Object[1];
            errArgs[0] = method;
            errMsg = MessageFormat.format(errMsg, errArgs);

            resp.sendError(501, errMsg);
        }
    }


    protected void doPost(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8;");
        HttpSession session = request.getSession(false);
        Login a = (Login) session.getAttribute("school_inspection");

        if(session.getAttribute("login_statu")!="true")
        {
        String userName = request.getParameter("school_id");
        String password = request.getParameter("school_psw");
        String ViewCode = request.getParameter("school_code");
        System.err.println(userName + ";" + password);
        try {
            if (a.load(ViewCode))
            {
                session.setAttribute("login_statu", "true");
                session.setAttribute("school_inspection",a);
                System.out.println(a.Returnname()+"第一次");
                PrintWriter out = response.getWriter();
                out.print("<script>alert('验证成功!')</script>");
            } else {
              PrintWriter out = response.getWriter();
               out.print("<script>alert('验证失败!')</script>");
                return;
            }
        } catch (Exception e) {
            e.printStackTrace(); }
            }//验证学校
        else//储存注册信息
        {
            String userName = request.getParameter("web_name");
            String useremail = request.getParameter("web_email");
            String password = request.getParameter("web_psw");
            String birdate = request.getParameter("datetimepicker");
            PrintWriter out = response.getWriter();
            System.out.println(a.Returnname()+a.ReturnID()+a.Returnpassword());
            System.out.println("___________________");
            System.out.println(a.ReturnID() +useremail+password+useremail+birdate);
            savaDataDAO sdata=new savaDataDAO();
            if(sdata.RegistStuInfo(a.ReturnID(),a.Returnname(),a.Returnpassword())!=true)
            {
                out.print("<script>alert('学校信息存储失败')</script>");
                return;
            }
            if(sdata.RegistWebInfo(a.ReturnID(),userName,password,useremail,birdate)!=true)
            {
                out.print("<script>alert('学校信息存储失败')</script>");
                return;
            }
            response.sendRedirect("do#svolet");
            out.print("<script>alert('您已经注册完成!')</script>");
            return;
        }





    }



    protected void doGet(javax.servlet.http.HttpServletRequest request, javax.servlet.http.HttpServletResponse response) throws javax.servlet.ServletException, IOException {
        HttpSession session = request.getSession(true);
        Login a = new Login();
        session.setAttribute("school_inspection", a);
        String  number=a.ReturnImgSrc() ;
        request.setAttribute("random",number);
        request.getRequestDispatcher("/WebContent/Login.jsp").forward(request, response);
    }
}