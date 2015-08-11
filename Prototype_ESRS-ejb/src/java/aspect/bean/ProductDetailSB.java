/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.db_connection.DatabaseConnection;
import aspect.model.Productdetail;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.ejb.Stateless;

/**
 *
 * @author eneye380
 */
@Stateless
public class ProductDetailSB implements ProductDetailSBLocal, Serializable {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private Connection conn;
    private ResultSet rs;
    private PreparedStatement ps, pp;
    private ArrayList<Productdetail> collec;
    private ArrayList<String> recommSet;
    private String prodid;
    private int index = 0;
    private DatabaseConnection dbConnect;

    public String getProdid() {
        System.out.println("meth: getProdid():String");
        return prodid;
    }

    public void setProdid(String prodid) {
        System.out.println("meth: setProdid(Str prodid)");
        this.prodid = prodid;
    }

    public ArrayList<String> getRecommSet() {
        System.out.println("meth: getRecommSet():ArrayList<String>");
        return recommSet;
    }

    public void setRecommSet(ArrayList<String> recommSet) {
        System.out.println("meth: setRecommSet(ArrL<Str> recommSet)");
        this.recommSet = recommSet;

    }

    public ArrayList<Productdetail> getCollec() {
        System.out.println("meth: getCollec():ArrayList<Productdetail>");
        return this.collec;
    }

    public void setCollec(Productdetail collec) {
        System.out.println("meth: getCollec()");
        this.collec.add(index, collec);
        index++;
    }

    public int getIndex() {
        System.out.println("meth: getIndex():int");
        return this.index;
    }

    public void setIndex(int i) {
        System.out.println("meth: setIndex(int i)");
        this.index = i;
    }

    public ProductDetailSB() {
        System.out.println("meth: productDetailSB()");
        collec = new ArrayList<>();
        recommSet = null;
        prodid = null;
    }

    public ArrayList<Productdetail> retrieveDetail() {
        System.out.println("meth: retrieveDetail():ArrayList<Productdetail>");
        System.out.println("prodid: " + prodid);
        System.out.println("recommSet: " + recommSet);

        try {
            dbConnect = new DatabaseConnection();
            conn = dbConnect.getDbConnection();
            System.out.println("Conn: " + conn);

            if (prodid != null) {

                Productdetail p = null;
                try {

                    p = this.processsDetail(prodid);

                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }

                this.setCollec(p);
                if (recommSet != null) {

                    if (recommSet.size() >= 1) {

                        for (String s : recommSet) {

                            Productdetail q = null;
                            try {
                                q = this.processsDetail(s);
                            } catch (SQLException ex) {
                                System.out.println("Error: " + ex);
                            }
                            this.setCollec(q);
                        }
                    }

                }
            }

            return this.getCollec();

        } catch (SQLException ex) {
            System.out.println("Error: " + ex);

            return null;

        } finally {

            dbConnect.closeDbConnection(conn, rs, ps);
        }

        //return this.getCollec();
    }

    public Productdetail processsDetail(String productid) throws SQLException {
        System.out.println("meth:processDetail(String prodid):Productdetail");
        try {

            ps = conn.prepareStatement("SELECT * FROM productdetail WHERE prodid = ?");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();
            Productdetail p = new Productdetail();
            while (rs.next()) {

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

            }

            return p;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
            return null;
        }
    }

}
