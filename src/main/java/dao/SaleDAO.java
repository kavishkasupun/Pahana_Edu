package dao;

import model.Invoice;
import model.Sale;
import model.SaleItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class SaleDAO {
    private Connection connection;

    public SaleDAO() {
        this.connection = DBConnection.getConnection();
    }

    public int createSale(Sale sale) {
        String sql = "INSERT INTO sales (customer_id, sale_date, total_amount, amount_paid, balance) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            statement.setInt(1, sale.getCustomerId());
            statement.setTimestamp(2, new Timestamp(System.currentTimeMillis()));
            statement.setDouble(3, sale.getTotalAmount());
            statement.setDouble(4, sale.getAmountPaid());
            statement.setDouble(5, sale.getBalance());
            
            int affectedRows = statement.executeUpdate();
            if (affectedRows == 0) {
                throw new SQLException("Creating sale failed, no rows affected.");
            }
            
            try (ResultSet generatedKeys = statement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating sale failed, no ID obtained.");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return -1;
        }
    }

    public boolean addSaleItem(SaleItem item) {
        String sql = "INSERT INTO sale_items (sale_id, product_id, quantity, unit_price, subtotal) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, item.getSaleId());
            statement.setInt(2, item.getProductId());
            statement.setInt(3, item.getQuantity());
            statement.setDouble(4, item.getUnitPrice());
            statement.setDouble(5, item.getSubtotal());
            
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Sale> getAllSales() {
        List<Sale> sales = new ArrayList<>();
        String sql = "SELECT s.*, c.name as customer_name FROM sales s LEFT JOIN customers c ON s.customer_id = c.id ORDER BY s.sale_date DESC";
        
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                Sale sale = new Sale();
                sale.setSaleId(resultSet.getInt("sale_id"));
                sale.setCustomerId(resultSet.getInt("customer_id"));
                sale.setCustomerName(resultSet.getString("customer_name"));
                sale.setSaleDate(resultSet.getTimestamp("sale_date"));
                sale.setTotalAmount(resultSet.getDouble("total_amount"));
                sale.setAmountPaid(resultSet.getDouble("amount_paid"));
                sale.setBalance(resultSet.getDouble("balance"));
                
                sales.add(sale);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sales;
    }

    public List<SaleItem> getSaleItems(int saleId) {
        List<SaleItem> items = new ArrayList<>();
        String sql = "SELECT si.*, p.product_name FROM sale_items si LEFT JOIN books p ON si.product_id = p.product_id WHERE si.sale_id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, saleId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    SaleItem item = new SaleItem();
                    item.setItemId(resultSet.getInt("item_id"));
                    item.setSaleId(resultSet.getInt("sale_id"));
                    item.setProductId(resultSet.getInt("product_id"));
                    item.setProductName(resultSet.getString("product_name"));
                    item.setQuantity(resultSet.getInt("quantity"));
                    item.setUnitPrice(resultSet.getDouble("unit_price"));
                    item.setSubtotal(resultSet.getDouble("subtotal"));
                    
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public List<Sale> getSalesByDate(Date date) {
        List<Sale> sales = new ArrayList<>();
        String sql = "SELECT s.*, c.name as customer_name FROM sales s LEFT JOIN customers c ON s.customer_id = c.id WHERE DATE(s.sale_date) = ? ORDER BY s.sale_date DESC";
        
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setDate(1, date);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Sale sale = new Sale();
                    sale.setSaleId(resultSet.getInt("sale_id"));
                    sale.setCustomerId(resultSet.getInt("customer_id"));
                    sale.setCustomerName(resultSet.getString("customer_name"));
                    sale.setSaleDate(resultSet.getTimestamp("sale_date"));
                    sale.setTotalAmount(resultSet.getDouble("total_amount"));
                    sale.setAmountPaid(resultSet.getDouble("amount_paid"));
                    sale.setBalance(resultSet.getDouble("balance"));
                    
                    sales.add(sale);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return sales;
    }
    
    public double getTotalSalesAmount() {
        String sql = "SELECT SUM(total) FROM invoices";
        try (Statement stmt = connection.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            if (rs.next()) {
                return rs.getDouble(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public Map<String, Double> getRecentSales(int days) {
        Map<String, Double> salesMap = new LinkedHashMap<>();
        String sql = "SELECT DATE(invoice_date) as sale_date, SUM(total) as daily_total " +
                     "FROM invoices " +
                     "WHERE invoice_date >= DATE_SUB(CURDATE(), INTERVAL ? DAY) " +
                     "GROUP BY DATE(invoice_date) " +
                     "ORDER BY sale_date";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, days);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                salesMap.put(rs.getString("sale_date"), rs.getDouble("daily_total"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return salesMap;
    }

    public List<Invoice> getRecentInvoices(int limit) {
        List<Invoice> invoices = new ArrayList<>();
        String sql = "SELECT * FROM invoices ORDER BY invoice_date DESC LIMIT ?";
        
        try (PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, limit);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                Invoice invoice = new Invoice();
                invoice.setInvoiceId(rs.getInt("invoice_id"));
                invoice.setCustomerId(rs.getInt("customer_id"));
                invoice.setInvoiceDate(rs.getTimestamp("invoice_date"));
                invoice.setTotal(rs.getDouble("total"));
                invoices.add(invoice);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return invoices;
    }
}