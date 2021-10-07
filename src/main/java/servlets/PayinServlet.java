package servlets;

import com.google.gson.Gson;
import entities.BoxAction;
import entities.Customer;
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

@WebServlet(name = "payinServlet" , value = {"/payin-post"})
public class PayinServlet extends HttpServlet {
    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pid = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            String obj = req.getParameter("obj");
            Gson gson = new Gson();
            Payment payment = gson.fromJson(obj, Payment.class);
            int cu_id = payment.getCu_id();
            int ba_id = payment.getBa_id();

            Payment paymentTable = (Payment) sesi.createQuery("from Payment where cu_id=:cu_id and ba_id=:ba_id")
                                                 .setParameter("ba_id", ba_id)
                                                 .setParameter("cu_id", cu_id)
                                                 .getSingleResult();


            //tabloda kayıtlı olan önceki ödenen + şimdi ödenenin toplanması
            paymentTable.setPy_PaymentAmount(paymentTable.getPy_PaymentAmount() + payment.getPy_PaymentAmount());
            //tabloda kayıtlı olan önceki kalan ödeme + şimdi ödenenin çıkarılması
            paymentTable.setPy_DebtAmount(paymentTable.getPy_DebtAmount());
            paymentTable.setPy_RemainAmount(paymentTable.getPy_DebtAmount() - paymentTable.getPy_PaymentAmount());

            paymentTable.setPy_Detail(payment.getPy_Detail());

            sesi.saveOrUpdate(paymentTable);
            tr.commit();
            sesi.close();
            pid = 1;
        } catch (Exception ex) {
            System.err.println("Payment Insert Error : " + ex);
        } finally {
            sesi.close();
        }
        resp.setContentType("application/json");
        resp.getWriter().write("" + pid);
    }
}
