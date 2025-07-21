package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.User;
import dao.DBConnection;

public class UserDAO {
    public User checkLogin(String usernameOrEmail, String password) {
        User user = null;
        try {
            Connection con = DBConnection.getConnection();
            // Check if the input is email or username
            String sql = "SELECT * FROM users WHERE (username=? OR email=?) AND password=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);
            ps.setString(3, password);
            ResultSet rs = ps.executeQuery();

            if(rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setVerified(rs.getBoolean("verified"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public String getAdminEmail() {
        String email = "";
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT email FROM users WHERE role='admin'";
            PreparedStatement ps = con.prepareStatement(sql);
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

    public boolean updatePassword(String email, String newPassword) {
        boolean status = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "UPDATE users SET password=(?) WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            status = ps.executeUpdate() > 0;
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return status;
    }
    
    public boolean emailExists(String email) {
        boolean exists = false;
        try {
            Connection con = DBConnection.getConnection();
            String sql = "SELECT email FROM users WHERE email=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            exists = rs.next();
            con.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return exists;
    }
    
    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, email, password, role, created_at) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY username";
        
        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setVerified(rs.getBoolean("verified"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }

    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}