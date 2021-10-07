package servlets;

import com.google.gson.Gson;
import entities.*;
import lombok.val;
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

@WebServlet(name = "boxActionServlet", value = {"/boxAction-post", "/boxAction-get", "/boxAction-getOrders","/boxAction-delete"})
public class BoxActionServlet extends HttpServlet {
    SessionFactory sf = HibernateUtil.getSessionFactory();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        Session sesi = sf.openSession();

        List<BoxAction> ls = sesi.createQuery("from BoxAction where orderStatus = false").getResultList();

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

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int return_id = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try {
            int ba_id = Integer.parseInt( req.getParameter("ba_id") );
            BoxAction boxAction = sesi.load(BoxAction.class, ba_id);
            sesi.delete(boxAction);
            tr.commit();
            return_id = boxAction.getBoxAction_id();
        }catch (Exception ex) {
            System.err.println("Delete Error : " + ex);
        }finally {
            sesi.close();
        }

        resp.setContentType("application/json");
        resp.getWriter().write( ""+return_id );
    }
}
