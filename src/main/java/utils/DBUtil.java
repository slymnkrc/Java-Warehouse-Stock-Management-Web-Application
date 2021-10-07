package utils;

import entities.Admin;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

public class DBUtil {

    SessionFactory sf = HibernateUtil.getSessionFactory();

    // index sayfası admin forum aksiyonları. Giriş Bilgileri Doğru ise Session ve Cookieler i üret.
    public boolean login(String ad_email, String ad_password, String ad_remember, HttpServletRequest req, HttpServletResponse resp) {
        boolean status = false;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            String sql = "from Admin where ad_email = :ad_email and ad_password = :ad_password";
            List<Admin> ls_admin = sesi.createQuery(sql).setParameter("ad_email", ad_email).setParameter("ad_password", ad_password).getResultList();
            // HATA YOKSA SESSION OLUSUR. ONCE SESSION SONRA COOKİE OLUSUCAK !!
            if (ls_admin.size() != 0) {
                status = true;
                ls_admin.forEach(item -> {
                    int ad_id = item.getAd_id();
                    String ad_username = item.getAd_username();
                    req.getSession().setAttribute("ad_id", ad_id);
                    req.getSession().setAttribute("ad_surname", ad_username);
                    System.out.println("Session oluşturuldu : ");

                    // COOKIE OLUSTURMA - SESSION SORUNSUZ OLUSURSA BURAYA GEL
                    if (ad_remember != null && ad_remember.equals("on")) {
                        ad_username = ad_username.replaceAll(" ", " ");
                        String val = ad_id + "_" + ad_username;
                        Cookie cookie = new Cookie("admin", val);
                        cookie.setMaxAge(60 * 60);
                        resp.addCookie(cookie);
                        System.out.println("Cookie oluşturuldu : ");

                    }

                });
            }
        } catch (Exception ex) {
            System.err.println("DBUtil_login_SesionCookieError : " + ex);
        } finally {
            sesi.close();
        }
        return status;
    }
}
