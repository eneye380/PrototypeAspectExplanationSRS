/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.db_connection.DatabaseConnection;
import aspect.model.Productaspectsentiment;
import aspect.model.ProductaspectsentimentPK;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.ejb.Stateless;

/**
 *
 * @author eneye380
 */
@Stateless
public class AspectScoreSB implements AspectScoreSBLocal {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
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

}
