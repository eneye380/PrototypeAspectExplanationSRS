/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package aspect.db_connection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;

/**
 *
 * @author eneye380
 */
public class DatabaseConnection {

    private final String db = "db1409777_esrs";
    private final String url = "jdbc:mysql://localhost:3306/db1409777_esrs";
    private final String username = "root";
    private final String password = "";
    private final Connection conn;
    private static int numberConnection = 0;

    public DatabaseConnection() throws SQLException {
        DatabaseConnection.setNumberConnection();
        try {
            try {
                Class.forName("com.mysql.jdbc.Driver").newInstance();
            } catch (InstantiationException | IllegalAccessException ex) {
                System.out.println("Error: unsuccessful Driver - " + ex);
            }
        } catch (ClassNotFoundException ex) {
            System.out.println("Error: unsuccessful Driver - " + ex);
        }
        System.out.println("New Db Connection Object created :- " + DatabaseConnection.getNumberConnection());

        conn = DriverManager.getConnection(url, username, password);
    }

    public Connection getDbConnection() {
        return conn;
    }

    public static int getNumberConnection() {
        return DatabaseConnection.numberConnection;
    }

    public static void setNumberConnection() {
        DatabaseConnection.numberConnection++;
    }

    public void closeDbConnection(Connection conn, ResultSet rs, PreparedStatement ps) {
        if (conn != null) {
            try {
                conn.close();
                System.out.println("Connection closed ");
            } catch (SQLException ex) {
                System.out.println("Error: " + ex);
            }
        }
        if (rs != null) {
            try {
                rs.close();
                System.out.println("ResultSet closed ");
            } catch (SQLException ex) {
                System.out.println("Error: " + ex);
            }
        }
        if (ps != null) {
            try {
                ps.close();
                System.out.println("PreparedStatement closed ");
            } catch (SQLException ex) {
                System.out.println("Error: " + ex);
            }
        }
    }
}
