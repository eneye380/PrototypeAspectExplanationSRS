/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.bean;

import aspect.model.Queryproductandrecommendation;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import javax.annotation.Resource;
import javax.ejb.Stateless;
import javax.sql.DataSource;

/**
 *
 * @author eneye380
 */
@Stateless
public class ProductSB implements ProductSBLocal {

    @Resource(name = "esrs")
    private DataSource esrs;
    private Connection conn = null;
    private ResultSet rs = null;
    private PreparedStatement ps = null, pp = null;

    //System.out.println("111");
    // Add business logic below. (Right-click in editor and choose
    // "Insert Code > Add Business Method")
    @Override
    public ArrayList<Queryproductandrecommendation> findProduct(String name) {
        System.out.println("111");
        Map<String, ArrayList> map = new HashMap();
        ArrayList<String> qp = new ArrayList();
        ArrayList<String> pd;
        try {
            conn = esrs.getConnection();
            System.out.println(conn);
            ps = conn.prepareStatement("SELECT * FROM queryproductandrecommendation WHERE name LIKE ?");
            pp = conn.prepareStatement("SELECT * FROM queryproductandrecommendation WHERE queryProduct LIKE ?");
            ps.setString(1, "%" + name + "%");
            pp.setString(1, "%" + name + "%");
            rs = ps.executeQuery();
            //rs = pp.executeQuery();
            ArrayList<Queryproductandrecommendation> recomm = new ArrayList<>();
            while (rs.next()) {
                Queryproductandrecommendation p = new Queryproductandrecommendation();
                p.setQueryProduct(rs.getString(1));
                p.setName(rs.getString(2));
                p.setRecommProduct1(rs.getString(3));
                p.setRecommProduct2(rs.getString(4));
                p.setRecommProduct3(rs.getString(5));
                recomm.add(p);
            }
            if (conn!= null){
                try {
                    conn.close();
                    System.out.println("Conn Closed ");
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (rs!=null){
                try {
                    rs.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (ps!=null){
                try {
                    ps.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            if (pp!=null){
                try {
                    pp.close();
                } catch (SQLException ex) {
                    System.out.println("Error: " + ex);
                }
            }
            return recomm;
        } catch (SQLException ex) {
            System.out.println("Error: " + ex);
        }  finally{
            
        }
        return null;
    }

}
