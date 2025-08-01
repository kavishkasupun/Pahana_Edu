package dao;

import model.InvoiceItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InvoiceItemDAO {
    private Connection connection;

    public InvoiceItemDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new RuntimeException("Failed to initialize database connection in InvoiceItemDAO");
        }
    }

    // Method with connection parameter (for transactional operations)
    public boolean addInvoiceItem(InvoiceItem item, Connection connection) {
        String sql = "INSERT INTO invoice_items (invoice_id, product_id, quantity, unit_price, total) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, item.getInvoiceId());
            statement.setInt(2, item.getProductId());
            statement.setInt(3, item.getQuantity());
            statement.setDouble(4, item.getUnitPrice());
            statement.setDouble(5, item.getTotal());
            
            int affectedRows = statement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println("Error adding invoice item: " + e.getMessage());
            throw new RuntimeException("Database error in addInvoiceItem: " + e.getMessage(), e);
        }
    }

    // Original method without connection parameter
    public boolean addInvoiceItem(InvoiceItem item) {
        return addInvoiceItem(item, this.connection);
    }

    // Method with connection parameter (for transactional operations)
    public List<InvoiceItem> getItemsByInvoiceId(int invoiceId, Connection connection) {
        List<InvoiceItem> items = new ArrayList<>();
        String sql = "SELECT * FROM invoice_items WHERE invoice_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, invoiceId);
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    InvoiceItem item = new InvoiceItem();
                    item.setItemId(resultSet.getInt("item_id"));
                    item.setInvoiceId(resultSet.getInt("invoice_id"));
                    item.setProductId(resultSet.getInt("product_id"));
                    item.setQuantity(resultSet.getInt("quantity"));
                    item.setUnitPrice(resultSet.getDouble("unit_price"));
                    item.setTotal(resultSet.getDouble("total"));
                    items.add(item);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting invoice items: " + e.getMessage());
            throw new RuntimeException("Database error in getItemsByInvoiceId: " + e.getMessage(), e);
        }
        return items;
    }

    // Original method without connection parameter
    public List<InvoiceItem> getItemsByInvoiceId(int invoiceId) {
        return getItemsByInvoiceId(invoiceId, this.connection);
    }
}