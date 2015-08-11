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
public class CategoryChoiceSB implements CategoryChoiceSBLocal, Serializable {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private String category;
    private String product;
    private ArrayList<CategoryChoiceSB> set;
    private Connection conn;
    private ResultSet rs;
    private PreparedStatement ps, pp;
    private DatabaseConnection dbConnect;

    public CategoryChoiceSB() {
        System.out.println("const:CategoryChoiceSB()");
        set = new ArrayList<>();
    }

    public void retrieveSet(String category) {
        System.out.println("meth:retrieveSet(str category)");
        try {

            System.out.println("Hello World");

            dbConnect = new DatabaseConnection();
            conn = dbConnect.getDbConnection();

            System.out.println("Connection: " + conn);

            //ps = conn.prepareStatement("SELECT * FROM queryproductandrecommendation WHERE queryProduct = ?");
            ps = conn.prepareStatement("SELECT * FROM productdetail WHERE category like ?");

            ps.setString(1, "%" + category + "%");
            System.out.println("CATEGORY: " + category);
            rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                CategoryChoiceSB a = new CategoryChoiceSB();
                a.setProduct(rs.getString(1));
                this.setSet(a);
                i++;
                if (i == 12) {
                    break;
                }

            }
            System.out.println("Count: " + i);

        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        } finally {
            dbConnect.closeDbConnection(conn, rs, ps);
        }

    }

    public String getProduct() {
        System.out.println("meth:getProduct():Str");
        return product;
    }

    public void setProduct(String product) {
        System.out.println("meth:setProduct(str prod)");
        this.product = product;
    }

    public ArrayList<CategoryChoiceSB> getSet() {
        System.out.println("meth:getSet():arrl<CategoryChoiceSB>");
        return set;
    }

    public void setSet(CategoryChoiceSB set) {
        System.out.println("meth:setSet(CategoryChoiceSB)");
        this.set.add(set);
    }

    public String getCategory() {
        System.out.println("meth:getCategory():Str");
        return category;
    }

    public void setCategory(String category) {
        System.out.println("meth:setCategory():Str");
        this.category = category;
        this.retrieveSet(this.getCategory());
    }

}
