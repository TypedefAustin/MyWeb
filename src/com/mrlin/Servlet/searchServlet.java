package com.mrlin.Servlet;

import WebPest.Databases.searchAccountDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "searchServlet")
public class searchServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=utf-8;");
        HttpSession session = request.getSession(true);
        String userpost = request.getParameter("spost1");
        String npsw = request.getParameter("npwd");
        if (userpost != null) {
            System.out.println(userpost);
            session.setAttribute("search", userpost);
            request.getRequestDispatcher("/WEB-INF/JSP/SocialSearchResults.jsp").forward(request, response);
        }
        if(npsw!=null) {
            PrintWriter out = response.getWriter();
            String opsw = request.getParameter("opwd");
            String rnpsw = request.getParameter("rnpwd");
            if(npsw!=rnpsw) {
                request.getRequestDispatcher("/WEB-INF/JSP/SocialSearchResults.jsp").forward(request, response);
                session.setAttribute("error","两次密码不一致");
                return;
            }
            String email = (String) session.getAttribute("Account");
            if (opsw != null && npsw != null && email != null) {
                searchAccountDAO account = new searchAccountDAO();
                if (account.searchNameAndPwd(email, opsw)) {
                    account.changePsw(email, npsw);
                    session.removeAttribute("IsLogin");
                    session.removeAttribute("Account");
                    request.getRequestDispatcher("/Web/WebContent/do#svolet").forward(request, response);
                    return;
                } else {
                    request.getRequestDispatcher("/WEB-INF/JSP/Error.jsp").forward(request, response);
                    session.setAttribute("error","密码不正确");
                    return;
                }
            }
            request.getRequestDispatcher("/WEB-INF/JSP/Error.jsp").forward(request, response);
            session.setAttribute("error","修改失败");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doPost(request, response);
    }
}
