package dao;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(
              "jdbc:mysql://localhost:3306/book_management", "root", "1234");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}
