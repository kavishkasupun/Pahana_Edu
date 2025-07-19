package dao;

import model.Product;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private Connection connection;

    public ProductDAO() {
        this.connection = DBConnection.getConnection();
    }

    // Add a new product
    public boolean addProduct(Product product) {
        String sql = "INSERT INTO products (category_id, product_name, description, price, quantity, image) VALUES (?, ?, ?, ?, ?, ?)";
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

    // Update a product
    public boolean updateProduct(Product product) {
        String sql = "UPDATE products SET category_id = ?, product_name = ?, description = ?, price = ?, quantity = ?, image = ? WHERE product_id = ?";
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
            e.printStackTrace();
            return false;
        }
    }

    // Delete a product
    public boolean deleteProduct(int productId) {
        String sql = "DELETE FROM products WHERE product_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, productId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all products with category names
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p LEFT JOIN categories c ON p.category_id = c.category_id";
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

    // Get products with low stock (quantity <= 5)
    public List<Product> getLowStockProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p LEFT JOIN categories c ON p.category_id = c.category_id WHERE p.quantity <= 5";
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

    // Get product by ID
    public Product getProductById(int productId) {
        String sql = "SELECT p.*, c.category_name FROM products p LEFT JOIN categories c ON p.category_id = c.category_id WHERE p.product_id = ?";
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
            e.printStackTrace();
        }
        return null;
    }

    // Search products by name
    public List<Product> searchProducts(String keyword) {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT p.*, c.category_name FROM products p LEFT JOIN categories c ON p.category_id = c.category_id WHERE p.product_name LIKE ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + keyword + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
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
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
}