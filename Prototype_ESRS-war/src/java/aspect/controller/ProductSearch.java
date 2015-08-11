/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.controller;

import aspect.bean.ProductSBLocal;
import aspect.model.Queryproductandrecommendation;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.ArrayList;
import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author eneye380
 */
public class ProductSearch extends HttpServlet {

    @EJB
    private ProductSBLocal productSB;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("121");
        response.setContentType("text/html;charset=UTF-8");
        //response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String keyword = request.getParameter("search");
            ArrayList<Queryproductandrecommendation> list = productSB.findProduct(keyword);
            System.out.println("Product Search: " + keyword);
            JSONObject json = new JSONObject();
            try {
                json.put("hello", "hi");
            } catch (JSONException ex) {
                out.println("JSON Error: " + ex);
            }
            out.println("KEY: " + keyword);
            out.println("ArraySize: " + list.size());
            out.println(json.toString());

            for (int i = 0; i < list.size(); i++) {
                Queryproductandrecommendation pr = list.get(i);
                out.println("Product Name: " + pr.getQueryProduct() + "<br>");
                out.println("Name: " + pr.getName() + "<br>");
                out.println("Recomm1: " + pr.getRecommProduct1() + "<br>");
                out.println("Recomm2: " + pr.getRecommProduct2() + "<br>");
                out.println("Recomm3: " + pr.getRecommProduct3() + "<br>");
                out.println("<br>");
            }
        } finally {
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
