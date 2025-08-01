package dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.Customer;

public class CustomerDAO {
    // No need for a connection field since we're getting connections from DBConnection
    
    public boolean addCustomer(Customer customer) {
        String sql = "INSERT INTO customers (account_number, name, address, telephone, email) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, customer.getAccountNumber());
            ps.setString(2, customer.getName());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getTelephone());
            ps.setString(5, customer.getEmail());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY name";
        
        try (Connection con = DBConnection.getConnection();
             Statement stmt = con.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Customer customer = new Customer();
                customer.setId(rs.getInt("id"));
                customer.setAccountNumber(rs.getString("account_number"));
                customer.setName(rs.getString("name"));
                customer.setAddress(rs.getString("address"));
                customer.setTelephone(rs.getString("telephone"));
                customer.setEmail(rs.getString("email"));
                customer.setCreatedAt(rs.getTimestamp("created_at"));
                customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public Customer getCustomerById(int id) {
        String sql = "SELECT * FROM customers WHERE id = ?";
        Customer customer = null;
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    customer = new Customer();
                    customer.setId(rs.getInt("id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setTelephone(rs.getString("telephone"));
                    customer.setEmail(rs.getString("email"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }

    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customers SET account_number=?, name=?, address=?, telephone=?, email=? WHERE id=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, customer.getAccountNumber());
            ps.setString(2, customer.getName());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getTelephone());
            ps.setString(5, customer.getEmail());
            ps.setInt(6, customer.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteCustomer(int id) {
        String sql = "DELETE FROM customers WHERE id = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    public List<Customer> searchCustomers(String keyword) {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE name LIKE ? OR account_number LIKE ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            String searchTerm = "%" + keyword + "%";
            ps.setString(1, searchTerm);
            ps.setString(2, searchTerm);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Customer customer = new Customer();
                    customer.setId(rs.getInt("id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setTelephone(rs.getString("telephone"));
                    customer.setEmail(rs.getString("email"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                    customers.add(customer);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public Customer getCustomerByAccountNumber(String accountNumber) {
        String sql = "SELECT * FROM customers WHERE account_number = ?";
        Customer customer = null;
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, accountNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    customer = new Customer();
                    customer.setId(rs.getInt("id"));
                    customer.setAccountNumber(rs.getString("account_number"));
                    customer.setName(rs.getString("name"));
                    customer.setAddress(rs.getString("address"));
                    customer.setTelephone(rs.getString("telephone"));
                    customer.setEmail(rs.getString("email"));
                    customer.setCreatedAt(rs.getTimestamp("created_at"));
                    customer.setUpdatedAt(rs.getTimestamp("updated_at"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customer;
    }
}