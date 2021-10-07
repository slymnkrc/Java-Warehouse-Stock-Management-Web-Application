package utils;

import entities.Admin;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Util {

    // BASE_URL
    public final static String base_url = "http://localhost:8080/depo_project_war_exploded/";

    
    // OTURUM ACMA LOGIN OLMA ISLEMLERI
    // COOKİE
    public Admin isLogin(HttpServletRequest req, HttpServletResponse resp) {
        if (req.getSession() != null) {
            Cookie[] cookies = req.getCookies();
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("admin")) {
                    String values = cookie.getValue();
                    try {
                        String[] arr = values.split("_");
                        req.getSession().setAttribute("ad_id", Integer.parseInt(arr[0]));
                        req.getSession().setAttribute("ad_username", Integer.parseInt(arr[1]));
                    } catch (Exception ex) {
                        Cookie cookie1 = new Cookie("admin", "");
                        cookie1.setMaxAge(0);
                        resp.addCookie(cookie1);
                        System.err.println("Util_isLogin_cookieError : " + ex);
                    }
                    break;
                }
            }
        }
        // SESSION
        Object sessionObject = req.getSession().getAttribute("ad_id");
        Admin admin = new Admin();
        if (sessionObject == null) {
            try {
                resp.sendRedirect(Util.base_url);
            }catch (Exception ex){
                System.err.println("Util_isLogin_sessionError : " + ex);
            }
        }
        else {
            int ad_id = (int) req.getSession().getAttribute("ad_id");
            String ad_username = (String) req.getSession().getAttribute("ad_username");
            admin.setAd_id(ad_id);
            admin.setAd_surname(ad_username);
        }
        return admin;
    }
}
