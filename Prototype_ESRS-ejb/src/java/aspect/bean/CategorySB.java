/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.db_connection.DatabaseConnection;
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
public class CategorySB implements CategorySBLocal {

    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    private ArrayList<CategorySB> catSet;
    private String category;
    private Connection conn;
    private ResultSet rs;
    private PreparedStatement ps, pp;
    private DatabaseConnection dbConnect;

    public CategorySB() {
        System.out.println("cons:Category()");
        catSet = new ArrayList<>();
        category = "";
    }

    public void setCategory(String cat) {
        System.out.println("meth:setCategory(str cat)");
        this.category = cat;
    }

    public String getCategory() {
        System.out.println("meth:getCategory():Str");
        return this.category;
    }

    public void setCatSet(CategorySB c) {
        System.out.println("meth:setCatSet(CategorySB c)");
        this.catSet.add(c);
    }

    public ArrayList<CategorySB> getCatSet() {
        System.out.println("meth:getCatSet():arrl<categorysb>");
        try {

            System.out.println("Hello World");

            dbConnect = new DatabaseConnection();
            conn = dbConnect.getDbConnection();

            System.out.println("Connection: " + conn);

            ps = conn.prepareStatement("SELECT DISTINCT category FROM productcategory");

            rs = ps.executeQuery();

            int i = 0;
            while (rs.next()) {
                CategorySB a = new CategorySB();
                a.setCategory(rs.getString(1));
                this.setCatSet(a);
                i++;
            }
            System.out.println("Count: " + i);

            return this.catSet;

        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
            return null;
        } finally {
            dbConnect.closeDbConnection(conn, rs, ps);
        }
    }
}
