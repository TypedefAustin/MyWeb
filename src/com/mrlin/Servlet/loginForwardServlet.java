package com.mrlin.Servlet;
import WebPest.Databases.searchAccountDAO;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "loginForwardServlet")
public class loginForwardServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8;");
        HttpSession session = request.getSession(true);
        String userpost = request.getParameter("login_email");
        String password = request.getParameter("login_psw");
        searchAccountDAO sa=new searchAccountDAO();
        if(sa.searchNameAndPwd(userpost,password))
        {
            session.setAttribute("IsLogin",userpost);
            request.getRequestDispatcher("/WEB-INF/JSP/ProfilePage.jsp").forward(request, response);
                                return;
        }

        else
        {
            response.sendRedirect("do#svolet");
            if (session.getAttribute("IsLogin")!=null)
            session.removeAttribute("IsLogin");
            return;
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
         this.doPost(request,response);
    }
}
