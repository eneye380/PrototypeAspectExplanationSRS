/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.db_connection.DatabaseConnection;
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
public class ProductSetSB implements ProductSetSBLocal, Serializable {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private String queryProduct;
    private ArrayList<ProductSetSB> set;
    private Connection conn;
    private ResultSet rs;
    private PreparedStatement ps, pp;
    private String product;
    private DatabaseConnection dbConnect;

    public ProductSetSB() {
        System.out.println("Const: ProductSetSB");
        set = new ArrayList<>();
    }

    //@Override
    public void retrieveSet(String productid) {
        System.out.println("Meth: retrieveSet(str prodid)");
        try {
            System.out.println("retrieveSet_try");
            dbConnect = new DatabaseConnection();
            conn = dbConnect.getDbConnection();

            System.out.println("Connection: " + conn);

            //ps = conn.prepareStatement("SELECT * FROM queryproductandrecommendation WHERE queryProduct = ?");
            ps = conn.prepareStatement("SELECT * FROM productrecommendation WHERE queryProduct = ?");

            ps.setString(1, "" + productid + "");

            rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                ProductSetSB a = new ProductSetSB();
                a.setProduct(rs.getString(2));
                this.setSet(a);
                i++;

            }
            System.out.println("Count: " + i);

        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        } finally {
            dbConnect.closeDbConnection(conn, rs, ps);
        }

    }

    public void setQueryProduct(String qp) {
        System.out.println("meth: setQueryProduct()");
        this.queryProduct = qp;
        System.out.println("Execute me once please:" + this.getQueryProduct());
        this.retrieveSet(this.getQueryProduct());
    }

    public String getQueryProduct() {
        System.out.println("meth: getQueryProduct()");
        return queryProduct;
    }

    public void setSet(ProductSetSB a) {
        System.out.println("meth: setSet(ProductSetSB a)");
        set.add(a);
    }

    public ArrayList<ProductSetSB> getSet() {
        System.out.println("meth: getSet():arrayl<productsetsb>");
        return set;
    }

    public void setProduct(String product) {
        System.out.println("meth: setProduct(str prod)");
        this.product = product;
    }

    public String getProduct() {
        System.out.println("meth: getProduct():str");
        return product;
    }

    public Connection getConn() {
        return conn;
    }
}
