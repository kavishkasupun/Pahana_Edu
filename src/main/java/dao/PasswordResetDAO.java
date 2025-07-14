package dao;

import java.sql.*;
import java.util.Date;
import dao.DBConnection;

public class PasswordResetDAO {
    public void createPasswordResetToken(String email, String token) {
        try {
            Connection con = DBConnection.getConnection();
            
            // Set expiration to 1 hour from now
            long expirationTime = System.currentTimeMillis() + 3600000; // 1 hour
            
            String sql = "INSERT INTO password_reset_tokens (email, token, expiration) VALUES (?, ?, ?)";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, token);
            ps.setTimestamp(3, new Timestamp(expirationTime));
            
            ps.executeUpdate();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    public String validatePasswordResetToken(String token) {
        String email = null;
        try {
            Connection con = DBConnection.getConnection();
            
            // Check if token exists and isn't expired
            String sql = "SELECT email FROM password_reset_tokens WHERE token=? AND expiration > ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, token);
            ps.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                email = rs.getString("email");
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return email;
    }
    
    public void deleteToken(String token) {
        try {
            Connection con = DBConnection.getConnection();
            String sql = "DELETE FROM password_reset_tokens WHERE token=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, token);
            ps.executeUpdate();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
}