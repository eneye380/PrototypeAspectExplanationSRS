/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.controller_bean;

import aspect.db_connection.DatabaseConnection;
import aspect.model.Productaspectsentiment;
import aspect.model.ProductaspectsentimentPK;
import aspect.model.ProductrecommendationPK;
import aspect.model.Queryproductandrecommendation;
import java.io.Serializable;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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
public class AspectScoreSB implements AspectScoreSBLocal, Serializable {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    @EJB
    private RecommendationSBLocal recommendationSB;
    private List<String> querywithrecommendedProduct;
    private ArrayList<Queryproductandrecommendation> list;
    private ArrayList<ProductrecommendationPK> list1;
    private String queryProdID;
    private JSONObject jsonDetailComplete;

    private Connection conn;
    private ResultSet rs;
    private PreparedStatement ps, pp;
    DatabaseConnection dbConnect;
    private ArrayList<String> recommSet;
    private String prodid;
    private ArrayList<String> myProducts;
    private Map<String, Number> aspectValue;
    private Map<String, Map<String, Number>> aspectSet;
    private Map<String, Map<String, Map<String, Number>>> scoreSet;

    public AspectScoreSB() {
        System.out.println("cons:AspectScoreSB()");
        recommSet = null;
        prodid = null;
        myProducts = new ArrayList<>();
        scoreSet = new HashMap<>();
    }

    public Map<String, Number> getAspectValue() {
        System.out.println("meth:getAspectValue():Map<String, Number>>");
        return aspectValue;
    }

    public void setAspectValue(Map<String, Number> aspectValue) {
        System.out.println("meth:setAspectValue(Map<String, Number>> aspectValue)");
        this.aspectValue = aspectValue;
    }

    public Map<String, Map<String, Number>> getAspectSet() {
        System.out.println("meth:getAspectSet():Map<String, Map<String, Number>>");
        return aspectSet;
    }

    public void setAspectSet(Map<String, Map<String, Number>> aspectSet) {
        System.out.println("meth:setAspectSet(Map<String, Map<String, Number>> aspectSet)");
        this.aspectSet = aspectSet;
    }

    public Map<String, Map<String, Map<String, Number>>> getScoreSet() {
        System.out.println("meth:getScoreSet():Map<String, Map<String, Map<String, Number>>>");
        return scoreSet;
    }

    public void setScoreSet(Map<String, Map<String, Map<String, Number>>> scoreSet) {
        System.out.println("meth:setScoreSet(Map<String, Map<String, Map<String, Number>>> scoreSet)");
        this.scoreSet = scoreSet;
    }

    public ArrayList<String> getRecommSet() {
        System.out.println("meth:getRecommSet():arrl<str>");
        return recommSet;
    }

    public void setRecommSet(ArrayList<String> recommSet) {
        System.out.println("meth:setRecommSet(arrl<str> recommSet):str");
        this.recommSet = recommSet;
    }

    public String getProdid() {
        System.out.println("meth:getProdid():str");
        return prodid;
    }

    public void setProdid(String prodid) {
        System.out.println("meth:setProdid(str prodid)");
        this.prodid = prodid;
    }

    public Map<String, Map<String, Map<String, Number>>> retrieveAspectScores() {
        System.out.println("meth:retrieveAspectScores():Map<String, Map<String, Map<String, Number>>>");
        BigDecimal score;
        int freq;
        BigDecimal gini;
        String aspect;

        if (prodid != null && recommSet != null) {
            myProducts.add(0, this.getProdid());
            if (recommSet.size() > 0) {
                for (int e = 0; e < recommSet.size(); e++) {
                    myProducts.add(e + 1, recommSet.get(e));
                }
            }
            for (int f = 0; f < myProducts.size(); f++) {
                ArrayList<Productaspectsentiment> p = this.processAspect(myProducts.get(f));
                aspectSet = new HashMap<>();
                for (int k = 0; k < p.size(); k++) {
                    aspectValue = new HashMap<>();
                    Productaspectsentiment pas = p.get(k);
                    aspect = pas.getProductaspectsentimentPK().getAspect();
                    score = pas.getScore();
                    freq = pas.getFreq();
                    gini = pas.getGini();
                    aspectValue.put("score", score);
                    aspectValue.put("freq", freq);
                    aspectValue.put("gini", gini);
                    aspectSet.put(aspect, aspectValue);
                }
                scoreSet.put(myProducts.get(f), aspectSet);
            }

        } else if(recommSet!=null){
            if (recommSet.size() > 0) {
                for (int e = 0; e < recommSet.size(); e++) {
                    myProducts.add(e, recommSet.get(e));
                }
            }
            for (int f = 0; f < myProducts.size(); f++) {
                ArrayList<Productaspectsentiment> p = this.processAspect(myProducts.get(f));
                aspectSet = new HashMap<>();
                for (int k = 0; k < p.size(); k++) {
                    aspectValue = new HashMap<>();
                    Productaspectsentiment pas = p.get(k);
                    aspect = pas.getProductaspectsentimentPK().getAspect();
                    score = pas.getScore();
                    freq = pas.getFreq();
                    gini = pas.getGini();
                    aspectValue.put("score", score);
                    aspectValue.put("freq", freq);
                    aspectValue.put("gini", gini);
                    aspectSet.put(aspect, aspectValue);
                }
                scoreSet.put(myProducts.get(f), aspectSet);
            }
        }
        System.out.println("MY SCORESET: " + scoreSet.toString());
        return scoreSet;
    }

    public ArrayList<Productaspectsentiment> processAspect(String productid) {
        System.out.println("meth:processAspect(str prodid):arrl<Productaspectsentiment>");

        try {
            dbConnect = new DatabaseConnection();
            conn = dbConnect.getDbConnection();
            System.out.println(conn);
            ps = conn.prepareStatement("SELECT * FROM productaspectsentiment WHERE prodid = ? ");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();
            ArrayList<Productaspectsentiment> collec = new ArrayList<>();

            while (rs.next()) {
                ProductaspectsentimentPK p = new ProductaspectsentimentPK();
                Productaspectsentiment q = new Productaspectsentiment(p);
                q.getProductaspectsentimentPK().setProdid(rs.getString(1));
                q.getProductaspectsentimentPK().setAspect(rs.getString(2));
                q.setScore(rs.getBigDecimal(3));
                q.setFreq(rs.getInt(4));
                q.setGini(rs.getBigDecimal(5));

                collec.add(q);
            }

            return collec;

        } catch (SQLException ex) {

            System.out.println("Error: " + ex);
            return null;

        } finally {
            dbConnect.closeDbConnection(conn, rs, ps);
        }

    }

    public JSONObject fetchAspectJSON() {
        System.out.println("meth:fetchAspectJSON():JSONObject");
        jsonDetailComplete = new JSONObject();
        System.out.println("hello LYI" + jsonDetailComplete);
        recommendationSB = new RecommendationSB();
        list1 = recommendationSB.retrieveRecommendation1(this.getProdid());
        System.out.println("hello len" + list1.toString());
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
            querywithrecommendedProduct.add(0, this.getProdid());
            //out.println("Unable to carry out request");
        }

        JSONObject myJson = recommendationSB.convertToJSON(querywithrecommendedProduct);

        try {
            int i = 1;
            if (m != null) {
                jsonrecomm.put("q", m.getQueryproduct());
                arrayrecomm.add(0, m.getQueryproduct());
            } else {
                jsonrecomm.put("q", this.getProdid());
                arrayrecomm.add(0, this.getProdid());
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
