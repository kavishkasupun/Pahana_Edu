package dao;

import model.Invoice;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class InvoiceDAO {
    private Connection connection;

    public InvoiceDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new RuntimeException("Failed to initialize database connection in InvoiceDAO");
        }
    }

    public int addInvoice(Invoice invoice, Connection connection) {
        String sql = "INSERT INTO invoices (customer_id, user_id, subtotal, total, amount_paid, balance, invoice_date) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, invoice.getCustomerId());
            statement.setInt(2, invoice.getUserId());
            statement.setDouble(3, invoice.getSubtotal());
            statement.setDouble(4, invoice.getTotal());
            statement.setDouble(5, invoice.getAmountPaid());
            statement.setDouble(6, invoice.getBalance());
            statement.setTimestamp(7, invoice.getInvoiceDate());
            
            int affectedRows = statement.executeUpdate();
            
            if (affectedRows == 0) {
                throw new SQLException("Creating invoice failed, no rows affected");
            }
            
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating invoice failed, no ID obtained");
                }
            }
        } catch (SQLException e) {
            System.err.println("Error adding invoice: " + e.getMessage());
            throw new RuntimeException("Database error in addInvoice: " + e.getMessage(), e);
        }
    }
    public List<Invoice> getAllInvoices() {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT * FROM invoices ORDER BY invoice_date DESC";
        
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                invoices.add(mapResultSetToInvoice(resultSet));
            }
        } catch (SQLException e) {
            System.err.println("Error getting all invoices: " + e.getMessage());
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return invoices;
    }

    public Invoice getInvoiceById(int invoiceId) {
        String sql = "SELECT * FROM invoices WHERE invoice_id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, invoiceId);
            
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    return mapResultSetToInvoice(resultSet);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting invoice by ID: " + e.getMessage());
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return null;
    }
    
    private Invoice mapResultSetToInvoice(ResultSet resultSet) throws SQLException {
        Invoice invoice = new Invoice();
        invoice.setInvoiceId(resultSet.getInt("invoice_id"));
        invoice.setCustomerId(resultSet.getInt("customer_id"));
        invoice.setUserId(resultSet.getInt("user_id"));
        invoice.setSubtotal(resultSet.getDouble("subtotal"));
        invoice.setTotal(resultSet.getDouble("total"));
        invoice.setAmountPaid(resultSet.getDouble("amount_paid"));
        invoice.setBalance(resultSet.getDouble("balance"));
        invoice.setInvoiceDate(resultSet.getTimestamp("invoice_date"));
        return invoice;
    }
    
    // Close connection when done (optional, better to use connection pooling)
    public void close() {
        DBConnection.closeConnection(connection);
    }
    
    public List<Invoice> getInvoicesByDateRange(java.util.Date startDate, java.util.Date endDate) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT * FROM invoices WHERE invoice_date BETWEEN ? AND ? ORDER BY invoice_date DESC";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setTimestamp(1, new Timestamp(startDate.getTime()));
            statement.setTimestamp(2, new Timestamp(endDate.getTime() + 86400000)); // Add 1 day to include end date
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    invoices.add(mapResultSetToInvoice(resultSet));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting invoices by date range: " + e.getMessage());
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return invoices;
    }

    public Map<String, Double> getDailySalesSummary(java.util.Date startDate, java.util.Date endDate) {
        Map<String, Double> dailySales = new LinkedHashMap<>();
        String sql = "SELECT DATE(invoice_date) as sale_date, SUM(total) as daily_total " +
                     "FROM invoices WHERE invoice_date BETWEEN ? AND ? " +
                     "GROUP BY DATE(invoice_date) ORDER BY sale_date";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setTimestamp(1, new Timestamp(startDate.getTime()));
            statement.setTimestamp(2, new Timestamp(endDate.getTime() + 86400000));
            
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    dailySales.put(
                        resultSet.getString("sale_date"),
                        resultSet.getDouble("daily_total")
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting daily sales summary: " + e.getMessage());
            throw new RuntimeException("Database error: " + e.getMessage(), e);
        }
        return dailySales;
    }
    
}