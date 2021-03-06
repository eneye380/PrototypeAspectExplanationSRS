/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.db_connection;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author eneye380
 */
public class DatabaseUpdate {
     private Connection conn;
    private ResultSet rs;
    private PreparedStatement ps, pp;
    private DatabaseConnection dbConnect;
    private ArrayList<String> tableNames;

    public DatabaseUpdate() throws SQLException {
        dbConnect = new DatabaseConnection();
    }

    public ArrayList<String> retrieveTableNames() throws SQLException {
        String sql = "select table_name from information_schema.tables where table_schema = 'db1409777_esrs'";
        conn = dbConnect.getDbConnection();
        ps = conn.prepareStatement(sql);
        rs = ps.executeQuery();
        tableNames = new ArrayList<>();
        while (rs.next()) {
            tableNames.add(rs.getString(1));
            System.out.println("Table Names:- " + rs.getString(1));
        }
        return tableNames;
    }

    public void createProductAspectSentimentTab() {
        String sqlString
                = "CREATE TABLE ProductAspectSentiment("
                + "prodid varchar(12), "
                + "aspect varchar(32),"
                + "score decimal(4,3),"
                + "freq int(255),"
                + "gini decimal(12,11),"
                + "PRIMARY KEY(prodid, aspect)"
                + ")";

        try {

            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            System.out.println("successfull");

        } catch (SQLException e) {
            System.out.println(e);
        }

        System.out.println(conn);
    }

    public void createProductDetailTab() {
        String sqlString
                = "CREATE TABLE IF NOT EXISTS ProductDetail("
                + "prodid varchar(15), "
                + "name text,"
                + "date varchar(12),"
                + "rank varchar(10),"
                + "price varchar(10),"
                + "category varchar(64),"
                + "rating varchar(10),"
                + "nreviews varchar(10),"
                + "ncomments varchar(10),"
                + "nquestions LONGBLOB,"
                + "url text,"
                + "PRIMARY KEY(prodid)"
                + ")";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            System.out.println("successfull");

        } catch (SQLException e) {
            System.out.println(e);
        }

        System.out.println(conn);
    }
    public void createProductReviewTab() {
        String sqlString
                = "CREATE TABLE IF NOT EXISTS ProductReview("
                + "author varchar(64), "
                + "prodid varchar(15),"
                + "badges varchar(32),"
                + "helpfulranking varchar(10),"
                + "title varchar(512),"
                + "date varchar(12),"
                + "rating varchar(10),"
                + "npeopleuseful varchar(10),"
                + "npeoplevoted varchar(10),"
                + "ncomments varchar(10),"
                + "comments text,"
                + "PRIMARY KEY(author,prodid)"
                + ")";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            System.out.println("successfull");

        } catch (SQLException e) {
            System.out.println(e);
        }

        System.out.println(conn);
    }

    public void createProductBoughtAfterTab() {
        String sqlString
                = "CREATE TABLE IF NOT EXISTS ProductBoughtAfter("
                + "prodid varchar(12), "
                + "productboughtafterurl text"
                + ")";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            System.out.println("successfull");

        } catch (SQLException e) {
            System.out.println(e);
        }

        System.out.println(conn);
    }
    public void createRecommendation() {
        String sqlString
                = "CREATE TABLE IF NOT EXISTS ProductRecommendation("
                + "queryproduct varchar(15), "
                + "recommendation varchar(15),"
                + "PRIMARY KEY(queryproduct,recommendation)"
                + ")";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            System.out.println("successfull");

        } catch (SQLException e) {
            System.out.println(e);
        }

        System.out.println(conn);
    }
    public void createCategory() {
        String sqlString
                = "CREATE TABLE IF NOT EXISTS Productcategory("
                + "category varchar(64), "                
                + "PRIMARY KEY(category)"
                + ")";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            System.out.println("successfull");

        } catch (SQLException e) {
            System.out.println(e);
        }

        System.out.println(conn);
    }
    public void insertRecommendationA(String[] s) {

        String sqlString = "INSERT INTO ProductRecommendation (queryproduct,recommendation) VALUES('" + s[0] + "','" + s[1] + "')";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            statement.executeUpdate(sqlString);
            System.out.println("Successfull-");

        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public void insertRecommendation(String s1, String s2) {

        String sqlString = "INSERT INTO ProductRecommendation (queryproduct,recommendation) VALUES('" + s1 + "','" + s2 + "')";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            statement.executeUpdate(sqlString);
            System.out.println("Successfull-");

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertRecordA(String[] s, File file) {
        //System.out.println("name-|- "+file.getName().substring( file.getName().lastIndexOf("-")+1, file.getName().lastIndexOf(".")));
        String productid = file.getName().substring( file.getName().lastIndexOf("-")+1, file.getName().lastIndexOf("."));
        String sqlString = "INSERT INTO ProductAspectSentiment VALUES('"+productid+"','" + s[0] + "','" + s[1] + "','" + s[2] + "','" + s[3] + "')";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            statement.executeUpdate(sqlString);
            System.out.println("Successfull-");

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertRecordD(String[] s) {

        String sqlString = "INSERT INTO ProductDetail VALUES('" + s[1] + "','" + s[2] + "','" + s[3] + "','" + s[4] + "','" + s[5] + "','" + s[6] + "','" + s[7] + "','" + s[8] + "','" + s[9] + "','" + s[10] + "','" + s[0] + "')";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            System.out.println("Successfull-");

        } catch (SQLException e) {
            System.out.println(e);
        }
    }
    public void insertRecordR(String[] s) {
        String ss = s[10];
        String sq = "";
        if(ss!=null){
        sq = ss.replaceAll("'", "''");
        }
        String sqlString = "INSERT INTO ProductReview VALUES('" + s[0] + "','" + s[1] + "','" + s[2] + "','" + s[3] + "','" + s[4] + "','" + s[5] + "','" + s[6] + "','" + s[7] + "','" + s[8] + "','" + s[9] + "','" + sq + "')";

        try {
            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            System.out.println("Successfull-");

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public void insertRecordV(String s) {

        String sqlString = "INSERT INTO ProductBoughtAfter VALUES('B00427Z7NM','" + s + "')";

        try {

            conn = dbConnect.getDbConnection();
            Statement statement = conn.createStatement();
            statement.executeUpdate(sqlString);
            System.out.println("Successfull-");

        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public static void main(String argv[]) throws SQLException {
        DatabaseUpdate d = new DatabaseUpdate();
        //run to create table
        //d.createProductReviewTab();
        //d.createProductAspectSentimentTab();
        //d.createCategory();
        d.createProductBoughtAfterTab();
        //d.createProductDetailTab();
        //d.createRecommendation();
    }
    
    public static void executeA(int i, String[] s){
        
    }

}
