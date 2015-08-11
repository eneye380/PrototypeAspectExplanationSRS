/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.controller;

import aspect.bean.RecommendationSBLocal;
import aspect.model.Productrecommendation;
import aspect.model.ProductrecommendationPK;
import aspect.model.Queryproductandrecommendation;
import java.io.IOException;
import java.io.PrintWriter;
import static java.lang.System.out;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
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
public class Recommendation extends HttpServlet {

    @EJB
    private RecommendationSBLocal recommendationSB;
    private List<String> querywithrecommendedProduct;
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
            String keyword = request.getParameter("product");
            System.out.println(keyword);
            //list = recommendationSB.retrieveRecommendation(keyword);
            list1 = recommendationSB.retrieveRecommendation1(keyword);
            JSONObject json = new JSONObject();
            JSONObject recomm = new JSONObject();
            JSONObject jsonrecomm = new JSONObject();
            JSONObject jsonDetailComplete = new JSONObject();
            List<String> arrayrecomm = new ArrayList<>();
            ProductrecommendationPK m =null;
            if (list1.size() >= 1) {
                querywithrecommendedProduct = new ArrayList<>();
                //Queryproductandrecommendation q = list.get(0);
                 m = list1.get(0);
                querywithrecommendedProduct.add(0, m.getQueryproduct());
                for (int j = 0; j < list1.size(); j++) {
                    ProductrecommendationPK p = list1.get(j);
                    querywithrecommendedProduct.add(j + 1, p.getRecommendation());
                }
            } else {
                querywithrecommendedProduct = new ArrayList<>();                
                querywithrecommendedProduct.add(0, keyword);
                //out.println("Unable to carry out request");
            }
                //String name = q.getName();
            //String queryProduct = q.getQueryProduct();
            //String recommendedProduct1 = q.getRecommProduct1();
            //String recommendedProduct2 = q.getRecommProduct2();
            //String recommendedProduct3 = q.getRecommProduct3();
            //querywithrecommendedProduct.add(0, queryProduct);
            //querywithrecommendedProduct.add(1, recommendedProduct1);
            //querywithrecommendedProduct.add(2, recommendedProduct2);
            //querywithrecommendedProduct.add(3, recommendedProduct3);
            JSONObject myJson = recommendationSB.convertToJSON(querywithrecommendedProduct);

            try {
                int i = 1;
                if(m!=null){
                jsonrecomm.put("q", m.getQueryproduct());
                arrayrecomm.add(0,m.getQueryproduct());
                }else{
                jsonrecomm.put("q", keyword);
                arrayrecomm.add(0,keyword);
                }
                for (int j = 0; j < list1.size(); j++) {
                    String r = "s";
                    r += i;
                    ProductrecommendationPK p = list1.get(j);
                    jsonrecomm.put(r, p.getRecommendation());
                    arrayrecomm.add(j+1,p.getRecommendation());
                    i++;
                    System.out.println("You're welcome ");
                }
                JSONArray jsonarray = new JSONArray(arrayrecomm);
                recomm.put("jsonrecomm",jsonrecomm);
                recomm.put("arrayrecomm",jsonarray);
                    //jsonrecomm.put("r1", recommendedProduct1);
                //jsonrecomm.put("r2", recommendedProduct1);
                //jsonrecomm.put("r3", recommendedProduct1);
                jsonDetailComplete.put("productlist", recomm);
                jsonDetailComplete.put("productdetails", myJson);
                out.println(jsonDetailComplete);
                //out.println("1erer1");
            } catch (JSONException ex) {
                System.out.println("Error: " + ex);
            }

            /**
             * if (list.size() == 1) { querywithrecommendedProduct = new
             * ArrayList<>(); Queryproductandrecommendation q = list.get(0);
             *
             * String name = q.getName(); String queryProduct =
             * q.getQueryProduct(); String recommendedProduct1 =
             * q.getRecommProduct1(); String recommendedProduct2 =
             * q.getRecommProduct2(); String recommendedProduct3 =
             * q.getRecommProduct3(); querywithrecommendedProduct.add(0,
             * queryProduct); querywithrecommendedProduct.add(1,
             * recommendedProduct1); querywithrecommendedProduct.add(2,
             * recommendedProduct2); querywithrecommendedProduct.add(3,
             * recommendedProduct3); JSONObject myJson =
             * recommendationSB.convertToJSON(querywithrecommendedProduct);
             *
             * try { jsonrecomm.put("q",queryProduct); jsonrecomm.put("r1",
             * recommendedProduct1); jsonrecomm.put("r2", recommendedProduct1);
             * jsonrecomm.put("r3", recommendedProduct1);
             * jsonDetailComplete.put("productlist", jsonrecomm);
             * jsonDetailComplete.put("productdetails",myJson);
             * out.println(jsonDetailComplete); //out.println("1erer1"); } catch
             * (JSONException ex) { System.out.println("Error: "+ex); }
             *
             *
             * } else { out.println("Unable to carry out request"); } if
             * (list.size() > 1) { for (int j = 0; j < list.size(); j++) {
             * Queryproductandrecommendation q = list.get(j); try {
             * json.put("name", q.getName()); json.put("query",
             * q.getQueryProduct()); json.put("r1", q.getRecommProduct1());
             * json.put("r2", q.getRecommProduct2()); json.put("r3",
             * q.getRecommProduct3()); out.println(json);
             *
             * } catch (JSONException ex) {
             *
             * }
             * //Json. System.out.println(q.getName()); } }
             */
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
