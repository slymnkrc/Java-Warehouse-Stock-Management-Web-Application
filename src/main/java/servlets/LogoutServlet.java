package servlets;

import utils.Util;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "logoutServlet",value = "/logout-servlet")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        //All Session Delete
        req.getSession().invalidate();

        //Cookies Delete
        Cookie cookie = new Cookie("user","");
        cookie.setMaxAge(0);
        resp.addCookie(cookie);

        resp.sendRedirect(Util.base_url);
    }
}
