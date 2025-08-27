package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO {

    private Connection testConnection = null;

    // Inject H2 test connection
    public void setTestConnection(Connection con) {
        this.testConnection = con;
    }

    protected Connection getConnection() throws SQLException {
        return (testConnection != null) ? testConnection : DBConnection.getConnection();
    }

    // Close connection only if it's not testConnection
    private void closeConnection(Connection con) {
        if (con != null && testConnection == null) {
            try { con.close(); } catch (SQLException ignored) {}
        }
    }

    public User checkLogin(String usernameOrEmail, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE (username=? OR email=?) AND password=?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, usernameOrEmail);
            ps.setString(2, usernameOrEmail);
            ps.setString(3, password);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setRole(rs.getString("role"));
                user.setVerified(rs.getBoolean("verified"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(SQLException ignored){}
            try { if(ps != null) ps.close(); } catch(SQLException ignored){}
            closeConnection(con);
        }
        return user;
    }

    public boolean addUser(User user) {
        String sql = "INSERT INTO users (username, email, password, role, created_at) VALUES (?, ?, ?, ?, ?)";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getRole());
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if(ps != null) ps.close(); } catch(SQLException ignored){}
            closeConnection(con);
        }
    }

    public boolean updatePassword(String email, String newPassword) {
        String sql = "UPDATE users SET password=? WHERE email=?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, newPassword);
            ps.setString(2, email);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if(ps != null) ps.close(); } catch(SQLException ignored){}
            closeConnection(con);
        }
    }

    public boolean emailExists(String email) {
        String sql = "SELECT email FROM users WHERE email=?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if(rs != null) rs.close(); } catch(SQLException ignored){}
            try { if(ps != null) ps.close(); } catch(SQLException ignored){}
            closeConnection(con);
        }
    }

    public String getAdminEmail() {
        String email = "";
        String sql = "SELECT email FROM users WHERE role='admin'";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            rs = ps.executeQuery();
            if (rs.next()) {
                email = rs.getString("email");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(SQLException ignored){}
            try { if(ps != null) ps.close(); } catch(SQLException ignored){}
            closeConnection(con);
        }
        return email;
    }

    public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM users ORDER BY username";
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            stmt = con.createStatement();
            rs = stmt.executeQuery(sql);
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
        } finally {
            try { if(rs != null) rs.close(); } catch(SQLException ignored){}
            try { if(stmt != null) stmt.close(); } catch(SQLException ignored){}
            closeConnection(con);
        }
        return users;
    }

    public boolean deleteUser(int id) {
        String sql = "DELETE FROM users WHERE id=?";
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if(ps != null) ps.close(); } catch(SQLException ignored){}
            closeConnection(con);
        }
    }
    
    public User getUserById(int id) {
        User user = null;
        String sql = "SELECT * FROM users WHERE id=?";
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {
                user = new User();
                user.setId(rs.getInt("id"));
                user.setUsername(rs.getString("username"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setVerified(rs.getBoolean("verified"));
                user.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try { if(rs != null) rs.close(); } catch(SQLException ignored){}
            try { if(ps != null) ps.close(); } catch(SQLException ignored){}
            closeConnection(con);
        }
        return user;
    }

    public boolean updateUser(User user) {
        String sql;
        Connection con = null;
        PreparedStatement ps = null;

        try {
            con = getConnection();
            
            // Update with or without password
            if (user.getPassword() != null && !user.getPassword().isEmpty()) {
                sql = "UPDATE users SET username=?, email=?, password=?, role=? WHERE id=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPassword());
                ps.setString(4, user.getRole());
                ps.setInt(5, user.getId());
            } else {
                sql = "UPDATE users SET username=?, email=?, role=? WHERE id=?";
                ps = con.prepareStatement(sql);
                ps.setString(1, user.getUsername());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getRole());
                ps.setInt(4, user.getId());
            }

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        } finally {
            try { if(ps != null) ps.close(); } catch(SQLException ignored){}
            closeConnection(con);
        }
    }
}
