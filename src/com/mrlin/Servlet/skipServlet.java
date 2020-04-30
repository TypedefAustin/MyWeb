package com.mrlin.Servlet;

import WebPest.Databases.savaDataDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "skipServlet")
public class skipServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8;");
        String content = request.getParameter("content");
        String email = request.getParameter("email");
        String topic = request.getParameter("topic");
        savaDataDAO save=new savaDataDAO();
        save.saveForums(email,content,topic);
        request.getRequestDispatcher("/WEB-INF/JSP/ForumsCategoryPage.jsp").forward(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String key = request.getParameter("key");//00刷新 01改密 02信息
        if(key.equals("00"))
        {
            request.getRequestDispatcher("/WEB-INF/JSP/ProfilePage.jsp").forward(request, response);
        }
        if(key.equals("01"))
        {
            request.getRequestDispatcher("/WEB-INF/JSP/ChangePsw.jsp").forward(request, response);
        }
        if(key.equals("02"))
        {
            request.getRequestDispatcher("/WEB-INF/JSP/PersonalInformation.jsp").forward(request, response);
        }
        if(key.equals("04"))
        {
            HttpSession session = request.getSession(false);
            if (session.getAttribute("IsLogin")!=null)
                session.removeAttribute("IsLogin");
            request.getRequestDispatcher("/WEB-INF/JSP/LoggedOut.jsp").forward(request, response);
        }
        if(key.equals("05"))
        {
            request.getRequestDispatcher("/WEB-INF/JSP/ForumsCategoryPage.jsp").forward(request, response);
        }
        if(key.equals("06"))
        {
            request.getRequestDispatcher("/WEB-INF/JSP/ForumsCreateTopic.jsp").forward(request, response);
        }
        if(key.equals("07"))
        {
            String tid = request.getParameter("Tid");
            HttpSession session = request.getSession(true);
            session.setAttribute("forumsdetail",tid);
            request.getRequestDispatcher("/WEB-INF/JSP/ForumsOpenTopic.jsp").forward(request, response);
        }
    }
}
