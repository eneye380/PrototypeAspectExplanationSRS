/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.model.Productaspectsentiment;
import aspect.model.ProductaspectsentimentPK;
import aspect.model.Productboughtafter;
import aspect.model.Productdetail;
import aspect.model.ProductrecommendationPK;
import aspect.model.Queryproductandrecommendation;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.sql.DataSource;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/**
 *
 * @author eneye380
 */
@Stateless
public class RecommendationSB implements RecommendationSBLocal {

    @Resource(name = "esrs")
    private DataSource esrs;
    private Connection conn = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null, pp = null;

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    @Override
    public ArrayList<Queryproductandrecommendation> retrieveRecommendation(String productid) {

        try {
            conn = esrs.getConnection();
            
            System.out.println("Connection: "+conn);
            System.out.println("Datasource: "+esrs);
            ps = conn.prepareStatement("SELECT * FROM queryproductandrecommendation WHERE queryProduct = ?");
            //ps = conn.prepareStatement("SELECT * FROM productrecommendation WHERE queryProduct = ?");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();
            ArrayList<Queryproductandrecommendation> collec = new ArrayList<>();
            //ArrayList<ProductrecommendationPK> collec = new ArrayList<>();

            while (rs.next()) {
                Queryproductandrecommendation p = new Queryproductandrecommendation();
                //ProductrecommendationPK p = new ProductrecommendationPK();
                p.setQueryProduct(rs.getString(1));
                p.setName(rs.getString(2));
                p.setRecommProduct1(rs.getString(3));
                p.setRecommProduct2(rs.getString(4));
                p.setRecommProduct3(rs.getString(5));
                //p.setQueryproduct(rs.getString(1));
                //p.setRecommendation(rs.getString(2));
                collec.add(p);
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            return collec;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        } finally {

        }
        return null;
    }
    @Override
    public ArrayList<ProductrecommendationPK> retrieveRecommendation1(String productid) {

        try {
            conn = esrs.getConnection();
            
            System.out.println("Connection: "+conn);
            System.out.println("Datasource: "+esrs);
            //ps = conn.prepareStatement("SELECT * FROM queryproductandrecommendation WHERE queryProduct = ?");
            ps = conn.prepareStatement("SELECT * FROM productrecommendation WHERE queryProduct = ?");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();
            //ArrayList<Queryproductandrecommendation> collec = new ArrayList<>();
            ArrayList<ProductrecommendationPK> collec = new ArrayList<>();

            while (rs.next()) {
                //Queryproductandrecommendation p = new Queryproductandrecommendation();
                ProductrecommendationPK p = new ProductrecommendationPK();
                //p.setQueryProduct(rs.getString(1));
                //p.setName(rs.getString(2));
                //p.setRecommProduct1(rs.getString(3));
                //p.setRecommProduct2(rs.getString(4));
                //p.setRecommProduct3(rs.getString(5));
                p.setQueryproduct(rs.getString(1));
                p.setRecommendation(rs.getString(2));
                collec.add(p);
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            return collec;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        } finally {

        }
        return null;
    }

    @Override
    public ArrayList<Productdetail> retrieveDetail(String productid) {
        System.out.println("getdetail_101");

        try {
            conn = esrs.getConnection();
            System.out.println(conn);
            ps = conn.prepareStatement("SELECT * FROM productdetail WHERE prodid = ?");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();
            ArrayList<Productdetail> collec = new ArrayList<>();

            while (rs.next()) {
                Productdetail p = new Productdetail();
                p.setProdid(rs.getString(1));
                p.setName(rs.getString(2));
                p.setDate(rs.getString(3));
                p.setRank(rs.getString(4));
                p.setPrice(rs.getString(5));
                p.setCategory(rs.getString(6));
                p.setRating(rs.getString(7));
                p.setNreviews(rs.getString(8));
                p.setNcomments(rs.getString(9));
                p.setNquestions(rs.getString(10));
                p.setUrl(rs.getString(11));
                collec.add(p);
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            return collec;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        } finally {

        }
        return null;

    }

    @Override
    public ArrayList<Productaspectsentiment> retrieveAspectSentimentScores(String productid) {
         System.out.println("getdetail_201");
        try {
            conn = esrs.getConnection();
            System.out.println(conn);
            ps = conn.prepareStatement("SELECT * FROM productaspectsentiment WHERE prodid = ?");

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
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            return collec;

        } catch (SQLException ex) {

            System.out.println("Error: " + ex);
            return null;

        } finally {

        }

    }

    @Override
    public ArrayList<Productboughtafter> retrieveBoughtAfterURL(String productid) {
         System.out.println("getdetail_301");
        try {
            conn = esrs.getConnection();
            System.out.println(conn);
            ps = conn.prepareStatement("SELECT * FROM productboughtafter WHERE prodid = ?");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();
            ArrayList<Productboughtafter> collec = new ArrayList<>();

            while (rs.next()) {
                Productboughtafter p = new Productboughtafter();

                p.setId(rs.getInt(1));
                p.setProdid(rs.getString(2));
                p.setProductboughtafterurl(rs.getString(3));

                collec.add(p);
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            return collec;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
            return null;
        } finally {

        }
    }

    @Override
    public JSONObject toJSONDetail(String productid) {
         System.out.println("getdetail_401");
        
        JSONObject json = new JSONObject();
       
        
        String prodid;
        String name;
        String date;
        String rank;
        String price;
        String category;
        String rating;
        String nreviews;
        String ncomments;
        String nquestions;
        String url;
        List<String> arrayOfUrl = new ArrayList<>();
        //Collection c = new ArrayList<>();

        ArrayList<Productdetail> list = this.retrieveDetail(productid);
        ArrayList<Productboughtafter> link = this.retrieveBoughtAfterURL(productid);
        if (list.size() == 1) {
            Productdetail pd = list.get(0);
            prodid = pd.getProdid();
            name = pd.getName();
            date = pd.getDate();
            rank = pd.getRank();
            price = pd.getPrice();
            category = pd.getCategory();
            rating = pd.getRating();
            nreviews = pd.getNreviews();
            ncomments = pd.getNcomments();
            nquestions = pd.getNquestions();
            url = pd.getUrl();
            for(int i=0;i<link.size();i++){
                Productboughtafter pba = link.get(i);
                arrayOfUrl.add(i,pba.getProductboughtafterurl());
            }
            JSONArray jsonarray = new JSONArray(arrayOfUrl);
            System.out.println("JSONarray: "+jsonarray);
            try {
                json.put("prodid",prodid);
                json.put("name",name);
                json.put("date",date);
                json.put("rank",rank);
                json.put("price",price);
                json.put("category", category);
                json.put("rating",rating);
                json.put("nreviews", nreviews);
                json.put("ncomments",ncomments);
                json.put("nquestions",nquestions);
                json.put("url",url);
                json.put("boughtafterurl",jsonarray);
                
            } catch (JSONException ex) {
                System.out.println("Error: "+ex);
            }
            
        }
        System.out.println("JSON: "+json);
        return json;
    }
    
    @Override
    public JSONObject toJSONAspectSentiment(String productid){
         System.out.println("getdetail_501");
        JSONObject json = new JSONObject();
        JSONObject j;
        
        BigDecimal score;
        int freq;
        BigDecimal gini;        
        String aspect;
        
        ArrayList<Productaspectsentiment> list = this.retrieveAspectSentimentScores(productid);
        if(list.size()>0){
            for(int i = 0; i<list.size();i++){
                j = new JSONObject();
                
                Productaspectsentiment pas = list.get(i);
                aspect=pas.getProductaspectsentimentPK().getAspect();
                score=pas.getScore();
                freq=pas.getFreq();
                gini=pas.getGini();
                try {
                    j.put("score",score);
                    j.put("freq",freq);
                    j.put("gini", gini);
                    json.put(aspect,j);
                } catch (JSONException ex) {
                    System.out.println("Error: "+ex);
                }
                
            }
            
        }
        System.out.println("JSON: "+json);
        return json;
    }
    
    public JSONArray toJSONAspectList(String productid){
        System.out.println("getdetail_501");
        JSONObject json = new JSONObject();
        JSONObject j;
        List<String> arrayOfAspects = new ArrayList<>();
        JSONArray jArrayOfAspects = null;
        
        BigDecimal score;
        int freq;
        BigDecimal gini;        
        String aspect;
        
        ArrayList<Productaspectsentiment> list = this.retrieveAspectSentimentScores(productid);
        if(list.size()>0){
            for(int i = 0; i<list.size();i++){
                j = new JSONObject();
                
                Productaspectsentiment pas = list.get(i);
                aspect=pas.getProductaspectsentimentPK().getAspect();
                score=pas.getScore();
                freq=pas.getFreq();
                gini=pas.getGini();
                try {
                    j.put("score",score);
                    j.put("freq",freq);
                    j.put("gini", gini);
                    json.put(aspect,j);
                    arrayOfAspects.add(i,aspect);
                } catch (JSONException ex) {
                    System.out.println("Error: "+ex);
                }                
            }
             jArrayOfAspects = new JSONArray(arrayOfAspects);
        }
        System.out.println("JSONArr: "+jArrayOfAspects);
        return jArrayOfAspects;
    }

    @Override
    public JSONObject convertToJSON(List list) {
         System.out.println("getdetail_601");
        JSONObject json, jsonAspect, jsonDetail;
        JSONObject jsonAll = new JSONObject();
        JSONArray jArrayAspectList;
        if (list != null) {
            for (int i = 0; i < list.size(); i++) {
                json = new JSONObject();
                jsonAspect = this.toJSONAspectSentiment((String) list.get(i));
                jsonDetail = this.toJSONDetail((String) list.get(i));
                jArrayAspectList = this.toJSONAspectList((String) list.get(i));
                try {
                    json.put("details", jsonDetail);
                    json.put("aspects",jsonAspect);
                    json.put("aspectList",jArrayAspectList);
                    jsonAll.put((String) list.get(i), json);
                } catch (JSONException ex) {
                    System.out.println("Error: "+ex);
                }
            }
        }
        System.out.println("JSON: "+jsonAll);
        return jsonAll;
    }

}
