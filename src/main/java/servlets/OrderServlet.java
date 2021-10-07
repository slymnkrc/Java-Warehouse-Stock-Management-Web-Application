package servlets;

import com.google.gson.Gson;
import entities.BoxAction;
import entities.Payment;
import entities.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import utils.HibernateUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "orderServlet", value = {"/orderAction-get", "/orderAction-post"})
public class OrderServlet extends HttpServlet {
    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        Session sesi = sf.openSession();

        List<BoxAction> ls = sesi.createQuery("from BoxAction where orderStatus = true").getResultList();

        sesi.close();

        String stJson = gson.toJson(ls);
        resp.setContentType("application/json");
        resp.getWriter().write(stJson);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pid = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            String obj = req.getParameter("obj");
            Gson gson = new Gson();
            BoxAction boxAction = gson.fromJson(obj, BoxAction.class);
            sesi.saveOrUpdate(boxAction);

            Product product = sesi.get(Product.class, boxAction.getPr_id());

            Payment payment = new Payment();
            payment.setBa_id(boxAction.getBoxAction_id());
            payment.setCu_id(boxAction.getCu_id());

            payment.setPy_DebtAmount(product.getPr_sale_price() * boxAction.getAmount());
            payment.setPy_RemainAmount(product.getPr_sale_price() * boxAction.getAmount());

            sesi.saveOrUpdate(payment);
            tr.commit();
            sesi.close();
            pid = 1;
        } catch (Exception ex) {
            System.err.println("BoxAction Insert Error : " + ex);
        } finally {
            sesi.close();
        }
        resp.setContentType("application/json");
        resp.getWriter().write("" + pid);
    }
}
