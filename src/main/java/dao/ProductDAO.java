package dao;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class ProductDAO {
    private Connection connection;

    public ProductDAO() {
        this.connection = DBConnection.getConnection();
        if (this.connection == null) {
            throw new RuntimeException("Failed to initialize database connection in ProductDAO");
        }
    }

    // Method with connection parameter (for InvoiceServlet)
    public boolean addProduct(Product product, Connection connection) {
        return addProduct(product); // Call the version without connection parameter
    }

    // Original method without connection parameter (for ProductServlet)
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO books (category_id, product_name, description, price, quantity, image) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, product.getCategoryId());
            statement.setString(2, product.getProductName());
            statement.setString(3, product.getDescription());
            statement.setDouble(4, product.getPrice());
            statement.setInt(5, product.getQuantity());
            statement.setBytes(6, product.getImage());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    

    // Original method without connection parameter (for ProductServlet)
 // Update the updateProduct methods to properly handle the connection parameter
    public boolean updateProduct(Product product, Connection connection) {
        String sql = "UPDATE books SET category_id = ?, product_name = ?, description = ?, price = ?, quantity = ?, image = ? WHERE product_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, product.getCategoryId());
            statement.setString(2, product.getProductName());
            statement.setString(3, product.getDescription());
            statement.setDouble(4, product.getPrice());
            statement.setInt(5, product.getQuantity());
            statement.setBytes(6, product.getImage());
            statement.setInt(7, product.getProductId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error updating product: " + e.getMessage());
            throw new RuntimeException("Database error in updateProduct: " + e.getMessage(), e);
        }
    }

    public boolean updateProduct(Product product) {
        return updateProduct(product, this.connection);
    }

    // Original method without connection parameter (for ProductServlet)
    public Product getProductById(int productId, Connection connection) {
        String sql = "SELECT p.*, c.category_name FROM books p LEFT JOIN items c ON p.category_id = c.category_id WHERE p.product_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, productId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Product product = new Product();
                    product.setProductId(resultSet.getInt("product_id"));
                    product.setCategoryId(resultSet.getInt("category_id"));
                    product.setProductName(resultSet.getString("product_name"));
                    product.setDescription(resultSet.getString("description"));
                    product.setPrice(resultSet.getDouble("price"));
                    product.setQuantity(resultSet.getInt("quantity"));
                    product.setImage(resultSet.getBytes("image"));
                    product.setCreatedAt(resultSet.getTimestamp("created_at"));
                    product.setUpdatedAt(resultSet.getTimestamp("updated_at"));
                    product.setCategoryName(resultSet.getString("category_name"));
                    return product;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error getting product by ID: " + e.getMessage());
            throw new RuntimeException("Database error in getProductById: " + e.getMessage(), e);
        }
        return null;
    }

    // Modify the existing method to call the version with connection parameter
    public Product getProductById(int productId) {
        return getProductById(productId, this.connection);
    }

    // Method with connection parameter (for InvoiceServlet)
    public List<Product> searchProducts(String keyword, String categoryId, Connection connection) {
        return searchProducts(keyword, categoryId); // Call the version without connection parameter
    }

    // Original method without connection parameter (for ProductServlet)
    public List<Product> searchProducts(String keyword, String categoryId) {
        List<Product> products = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
            "SELECT p.*, c.category_name FROM books p LEFT JOIN items c ON p.category_id = c.category_id WHERE 1=1");
        
        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (p.product_name LIKE ? OR p.description LIKE ?)");
        }
        
        if (categoryId != null && !categoryId.isEmpty()) {
            sql.append(" AND p.category_id = ?");
        }
        
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            
            int paramIndex = 1;
            if (keyword != null && !keyword.isEmpty()) {
                String searchTerm = "%" + keyword + "%";
                ps.setString(paramIndex++, searchTerm);
                ps.setString(paramIndex++, searchTerm);
            }
            
            if (categoryId != null && !categoryId.isEmpty()) {
                ps.setInt(paramIndex, Integer.parseInt(categoryId));
            }
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Product product = new Product();
                    product.setProductId(rs.getInt("product_id"));
                    product.setCategoryId(rs.getInt("category_id"));
                    product.setProductName(rs.getString("product_name"));
                    product.setDescription(rs.getString("description"));
                    product.setPrice(rs.getDouble("price"));
                    product.setQuantity(rs.getInt("quantity"));
                    
                    // Handle BLOB image safely
                    Blob imageBlob = rs.getBlob("image");
                    if (imageBlob != null && imageBlob.length() > 0) {
                        try {
                            byte[] imageBytes = imageBlob.getBytes(1, (int) imageBlob.length());
                            product.setImage(imageBytes);
                            product.setImageBase64(Base64.getEncoder().encodeToString(imageBytes));
                        } catch (SQLException e) {
                            System.err.println("Error processing image blob: " + e.getMessage());
                            product.setImageBase64(""); // Set empty if error
                        }
                    } else {
                        product.setImageBase64(""); // Set empty if no image
                    }
                    
                    product.setCreatedAt(rs.getTimestamp("created_at"));
                    product.setUpdatedAt(rs.getTimestamp("updated_at"));
                    product.setCategoryName(rs.getString("category_name"));
                    products.add(product);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error searching products: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Database error while searching products", e);
        } catch (Exception e) {
            System.err.println("Unexpected error searching products: " + e.getMessage());
            throw new RuntimeException("Unexpected error while searching products", e);
        }
        return products;
    }

    // Keep all other existing methods as they are
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM books p LEFT JOIN items c ON p.category_id = c.category_id";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setProductName(resultSet.getString("product_name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setImage(resultSet.getBytes("image"));
                product.setCreatedAt(resultSet.getTimestamp("created_at"));
                product.setUpdatedAt(resultSet.getTimestamp("updated_at"));
                product.setCategoryName(resultSet.getString("category_name"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public List<Product> getLowStockProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM books p LEFT JOIN items c ON p.category_id = c.category_id WHERE p.quantity <= 5";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            while (resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setCategoryId(resultSet.getInt("category_id"));
                product.setProductName(resultSet.getString("product_name"));
                product.setDescription(resultSet.getString("description"));
                product.setPrice(resultSet.getDouble("price"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setImage(resultSet.getBytes("image"));
                product.setCreatedAt(resultSet.getTimestamp("created_at"));
                product.setUpdatedAt(resultSet.getTimestamp("updated_at"));
                product.setCategoryName(resultSet.getString("category_name"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM books WHERE product_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, productId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}