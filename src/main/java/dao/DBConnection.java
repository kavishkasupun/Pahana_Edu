package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/book_management"; // Change to your database name
    private static final String USER = "root";
    private static final String PASSWORD = "1234"; // Change to your database password
    
    // Private constructor to prevent instantiation
    private DBConnection() {}
    
    public static Connection getConnection() {
        Connection connection = null;
        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Create the connection
            connection = DriverManager.getConnection(URL, USER, PASSWORD);
            
            // Test the connection
            if (connection != null && !connection.isClosed()) {
                System.out.println("Database connection established successfully");
            }
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Failed to establish database connection");
            e.printStackTrace();
        }
        return connection;
    }
    
    public static void closeConnection(Connection connection) {
        if (connection != null) {
            try {
                connection.close();
                System.out.println("Database connection closed");
            } catch (SQLException e) {
                System.err.println("Failed to close database connection");
                e.printStackTrace();
            }
        }
    }
}