/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.db_connection.DatabaseConnection;
import aspect.model.Productreview;
import aspect.model.ProductreviewPK;
import java.io.Serializable;
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
public class ProductReviewSB implements ProductReviewSBLocal, Serializable {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private Connection conn;
    private ResultSet rs;
    private PreparedStatement ps, pp;
    DatabaseConnection dbConnect;
    private ArrayList<String> recommSet;
    private String prodid;
    private ArrayList<String> myProducts;
    private Map<String, String> productReviewValues;
    private Map<String, Map<String, String>> reviewSet;
    private Map<String, Map<String, Map<String, String>>> productReviewSet;

    public ProductReviewSB() {
        System.out.println("cons:ProductReviewSB()");
        recommSet = null;
        prodid = null;
        myProducts = new ArrayList<>();
        productReviewSet = new HashMap<>();
    }

    public Map<String, String> getProductReviewValues() {
        System.out.println("meth:getProductReviewValues():Map<String, Number>>");
        return productReviewValues;
    }

    public void setProductReviewValues(Map<String, String> aspectValue) {
        System.out.println("meth:setProductReviewValues(Map<String, Number>> aspectValue)");
        this.productReviewValues = aspectValue;
    }

    public Map<String, Map<String, String>> getReviewSet() {
        System.out.println("meth:getReviewSet():Map<String, Map<String, Number>>");
        return reviewSet;
    }

    public void setReviewSet(Map<String, Map<String, String>> aspectSet) {
        System.out.println("meth:setReviewSet(Map<String, Map<String, Number>> aspectSet)");
        this.reviewSet = aspectSet;
    }

    public Map<String, Map<String, Map<String, String>>> getProductReviewSet() {
        System.out.println("meth:getProductReviewSet():Map<String, Map<String, Map<String, Number>>>");
        return productReviewSet;
    }

    public void setProductReviewSet(Map<String, Map<String, Map<String, String>>> scoreSet) {
        System.out.println("meth:setProductReviewSet(Map<String, Map<String, Map<String, Number>>> scoreSet)");
        this.productReviewSet = scoreSet;
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

    public Map<String, Map<String, Map<String, String>>> retrieveProductReview() {
        System.out.println("meth:retrieveAspectScores():Map<String, Map<String, Map<String, Number>>>");
        
        String author, productid, badges, helpfulranking, title, date, rating, npeopleuseful, npeoplevoted, ncomments, comment;

        if (prodid != null && recommSet != null) {
            myProducts.add(0, this.getProdid());
            if (recommSet.size() > 0) {
                for (int e = 0; e < recommSet.size(); e++) {
                    myProducts.add(e + 1, recommSet.get(e));
                }
            }
            for (int f = 0; f < myProducts.size(); f++) {
                ArrayList<Productreview> p = this.processReview(myProducts.get(f));
                reviewSet = new HashMap<>();
                for (int k = 0; k < p.size(); k++) {
                    productReviewValues = new HashMap<>();
                    Productreview pas = p.get(k);
                    author = pas.getProductreviewPK().getAuthor();
                    productid = pas.getProductreviewPK().getProdid();
                    badges = pas.getBadges();
                    helpfulranking = pas.getHelpfulranking();
                    title = pas.getTitle();
                    date = pas.getDate();
                    rating = pas.getRating();
                    npeopleuseful = pas.getNpeopleuseful();
                    npeoplevoted = pas.getNpeoplevoted();
                    ncomments = pas.getNcomments();
                    comment = pas.getComments();

                    productReviewValues.put("author", author);
                    productReviewValues.put("productid", productid);
                    productReviewValues.put("badges", badges);
                    productReviewValues.put("helpfulranking", helpfulranking);
                    productReviewValues.put("title", title);
                    productReviewValues.put("date", date);
                    productReviewValues.put("rating", rating);
                    productReviewValues.put("npeopleuseful", npeopleuseful);
                    productReviewValues.put("npeoplevoted", npeoplevoted);
                    productReviewValues.put("ncomments", ncomments);
                    productReviewValues.put("comment", comment);

                    reviewSet.put(author, productReviewValues);
                }
                productReviewSet.put(myProducts.get(f), reviewSet);
            }

        }
        System.out.println("MY SCORESET: " + productReviewSet.toString());
        return productReviewSet;
    }

    public ArrayList<Productreview> processReview(String productid) {
        System.out.println("meth:processReview(str prodid):arrl<Productreview>");

        try {
            dbConnect = new DatabaseConnection();
            conn = dbConnect.getDbConnection();
            System.out.println(conn);
            ps = conn.prepareStatement("SELECT * FROM productreview WHERE prodid = ? ");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();
            ArrayList<Productreview> collec = new ArrayList<>();

            while (rs.next()) {
                ProductreviewPK p = new ProductreviewPK();
                Productreview q = new Productreview(p);
                q.getProductreviewPK().setAuthor(rs.getString(1));
                q.getProductreviewPK().setProdid(rs.getString(2));
                q.setBadges(rs.getString(3));
                q.setHelpfulranking(rs.getString(4));
                q.setTitle(rs.getString(5));
                q.setDate(rs.getString(6));
                q.setRating(rs.getString(7));
                q.setNpeopleuseful(rs.getString(8));
                q.setNpeoplevoted(rs.getString(9));
                q.setNcomments(rs.getString(10));
                q.setComments(rs.getString(11));

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
