/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.servlet;

import aspect.controller_bean.ProductSBLocal;
import aspect.controller_bean.RecommendationSB;
import aspect.controller_bean.RecommendationSBLocal;
import aspect.model.ProductrecommendationPK;
import aspect.model.Queryproductandrecommendation;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import javax.ejb.EJB;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author eneye380
 */
public class ProductComparison extends HttpServlet {

    @EJB
    private RecommendationSBLocal recommendationSB;
    private List<String> productForComparison;
    private ArrayList<Queryproductandrecommendation> list;
    private ArrayList<ProductrecommendationPK> list1;

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
        //response.setContentType("text/html;charset=UTF-8");
        response.setContentType("application/json");
        //response.setCharacterEncoding("UTF-8");
        System.out.println("787");

        //response.setContentType("application/json");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            /*String keyword1 = request.getParameter("product1");
             String keyword2 = request.getParameter("product2");
             String keyword3 = request.getParameter("product3");            
             System.out.println(keyword1);
             System.out.println(keyword2);
             System.out.println(keyword3);*/
            String[] prod = request.getParameterValues("s");
            for (String prod1 : prod) {
                System.out.println("ParaValue: " + prod1);
            }

            JSONObject json = new JSONObject();
            JSONObject recomm = new JSONObject();
            JSONObject jsonrecomm = new JSONObject();
            JSONObject jsonDetailComplete = new JSONObject();
            List<String> arrayrecomm = new ArrayList<>();

            productForComparison = new ArrayList<>();
            if (prod.length > 0 && prod.length <= 3) {
                productForComparison.addAll(Arrays.asList(prod));
            }
            /*if (keyword1!=null) {                
             productForComparison.add(keyword1);
             } 
             if (keyword2!=null) {                
             productForComparison.add(keyword2);
             } 
             if (keyword3!=null) {                
             productForComparison.add(keyword3);
             } */
            recommendationSB = new RecommendationSB();
            JSONObject myJson = recommendationSB.convertToJSON(productForComparison);

            try {
                int i = 1;

                for (int j = 0; j < productForComparison.size(); j++) {
                    String r = "s";
                    r += i;
                    jsonrecomm.put(r, productForComparison.get(j));
                    arrayrecomm.add(j, productForComparison.get(j));
                    i++;
                    System.out.println("You're welcome ");
                }
                JSONArray jsonarray = new JSONArray(arrayrecomm);
                recomm.put("jsonrecomm", jsonrecomm);
                recomm.put("arrayrecomm", jsonarray);

                jsonDetailComplete.put("productlist", recomm);
                jsonDetailComplete.put("productdetails", myJson);
                out.println(jsonDetailComplete);
                //out.println("1erer1");
            } catch (JSONException ex) {
                System.out.println("Error: " + ex);
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
