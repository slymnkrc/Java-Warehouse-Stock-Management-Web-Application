package servlets;

import com.google.gson.Gson;

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

@WebServlet(name="productServlet", value = {"/product-post","/product-get","/product-delete"})
public class ProductServlet extends HttpServlet {

    SessionFactory sf = HibernateUtil.getSessionFactory();

    // product - insert


    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int pid = 0;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try{
            String obj = req.getParameter("obj");
            Gson gson = new Gson();
            Product product = gson.fromJson(obj, Product.class);
            sesi.saveOrUpdate(product);
            tr.commit();
            sesi.close();
            pid = 1;
        }catch (Exception ex){
            System.err.println("Product Insert Error : " + ex);
        }finally {
            sesi.close();
        }
        resp.setContentType("application/json");
        resp.getWriter().write("" +pid);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Gson gson = new Gson();
        Session sesi = sf.openSession();
        List<Product> ls = sesi.createQuery("from Product").getResultList();
        sesi.close();

        String stJson = gson.toJson(ls);
        resp.setContentType("application/json");
        resp.getWriter().write( stJson );
    }

    // product - delete


    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int return_id = 0 ;
        Session sesi = sf.openSession();
        Transaction tr = sesi.beginTransaction();
        try{
            int pr_id = Integer.parseInt( req.getParameter("pr_id") );
            Product product = sesi.load(Product.class, pr_id);
            sesi.delete(product);
            tr.commit();
            return_id = product.getPr_id();
        }catch (Exception ex){
            System.err.println("Delete Product Error : "  + ex);
        }finally {
            sesi.close();
        }
        resp.setContentType("application/json");
        resp.getWriter().write(""+return_id);
    }
}
