package servlets;

import com.google.gson.Gson;
import entities.BoxAction;
import entities.Payment;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import utils.HibernateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "paidOrderServlet", value = {"/paidOrderServlet-get", "/paidOrderServlet-post"})
public class PaidOrderServlet extends HttpServlet {
    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        Session sesi = sf.openSession();

        List<Payment> ls = sesi.createQuery("from Payment where py_PaymentAmount > 0").getResultList();

        sesi.close();

        String stJson = gson.toJson(ls);
        resp.setContentType("application/json");
        resp.getWriter().write(stJson);
    }
}
