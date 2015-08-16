/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.controller_bean;

import aspect.model.ProductrecommendationPK;
import aspect.model.Queryproductandrecommendation;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.ejb.EJB;
import javax.ejb.Stateless;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author eneye380
 */
@Stateless
public class AspectScoreJSONSB implements AspectScoreJSONSBLocal, Serializable {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    @EJB
    private RecommendationSBLocal recommendationSB;
    private List<String> querywithrecommendedProduct;
    private ArrayList<Queryproductandrecommendation> list;
    private ArrayList<ProductrecommendationPK> list1;
    private String queryProdID;
    private JSONObject jsonDetailComplete;

    public AspectScoreJSONSB() {
        jsonDetailComplete = new JSONObject();
        System.out.println("AspectScoreJSONSB");
    }
    
    

    public String getQueryProdID() {
        return queryProdID;
    }

    public void setQueryProdID(String queryProdID) {
        this.queryProdID = queryProdID;
    }
    @Override
    public  JSONObject fetchAspectJSON(){
        recommendationSB = new RecommendationSB();
        list1 = recommendationSB.retrieveRecommendation1(this.getQueryProdID());
            JSONObject json = new JSONObject();
            JSONObject recomm = new JSONObject();
            JSONObject jsonrecomm = new JSONObject();
            //JSONObject jsonDetailComplete = new JSONObject();
            List<String> arrayrecomm = new ArrayList<>();
            ProductrecommendationPK m = null;
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
                querywithrecommendedProduct.add(0, this.getQueryProdID());
                //out.println("Unable to carry out request");
            }
          
            JSONObject myJson = recommendationSB.convertToJSON(querywithrecommendedProduct);

            try {
                int i = 1;
                if (m != null) {
                    jsonrecomm.put("q", m.getQueryproduct());
                    arrayrecomm.add(0, m.getQueryproduct());
                } else {
                    jsonrecomm.put("q", this.getQueryProdID());
                    arrayrecomm.add(0, this.getQueryProdID());
                }
                for (int j = 0; j < list1.size(); j++) {
                    String r = "s";
                    r += i;
                    ProductrecommendationPK p = list1.get(j);
                    jsonrecomm.put(r, p.getRecommendation());
                    arrayrecomm.add(j + 1, p.getRecommendation());
                    i++;
                    System.out.println("You're welcome ");
                }
                JSONArray jsonarray = new JSONArray(arrayrecomm);
                recomm.put("jsonrecomm", jsonrecomm);
                recomm.put("arrayrecomm", jsonarray);
                
                jsonDetailComplete.put("productlist", recomm);
                jsonDetailComplete.put("productdetails", myJson);
                
                //out.println("1erer1");
            } catch (JSONException ex) {
                System.out.println("Error: " + ex);
            } 
        
        return jsonDetailComplete;
    } 
}
