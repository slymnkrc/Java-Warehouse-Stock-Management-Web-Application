package servlets;

import utils.DBUtil;
import utils.Util;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/login-servlet")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String ad_email = req.getParameter("email");
        String ad_password = req.getParameter("password");
        String ad_remember = req.getParameter("remember");

        DBUtil dbUtil = new DBUtil();
        boolean status = dbUtil.login(ad_email, ad_password, ad_remember, req, resp);
        if (status) {
            resp.sendRedirect(Util.base_url + "dashboard.jsp");
        } else {
            req.setAttribute("loginError", "E-Mail ya da Şifre Bilgisi Hatalı! Tekrar Deneyiniz");
            RequestDispatcher requestDispatcher = getServletContext().getRequestDispatcher("/index.jsp");
            requestDispatcher.forward(req, resp);
        }

    }
}
