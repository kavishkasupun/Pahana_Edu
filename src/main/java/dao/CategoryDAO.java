package dao;

import model.Category;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAO {
    private Connection connection;

    public CategoryDAO() {
        this.connection = DBConnection.getConnection();
    }

    // Add a new category
    public boolean addCategory(Category category) {
        String sql = "INSERT INTO items (category_name, description) VALUES (?, ?)";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, category.getCategoryName());
            statement.setString(2, category.getDescription());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update a category
    public boolean updateCategory(Category category) {
        String sql = "UPDATE items SET category_name = ?, description = ? WHERE category_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, category.getCategoryName());
            statement.setString(2, category.getDescription());
            statement.setInt(3, category.getCategoryId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a category
    public boolean deleteCategory(int categoryId) {
        String sql = "DELETE FROM items WHERE category_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, categoryId);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all items
    public List<Category> getAllCategories() {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM items";
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(sql)) {
            
            System.out.println("Executing query: " + sql); // Debug log
            
            while (resultSet.next()) {
                Category category = new Category();
                category.setCategoryId(resultSet.getInt("category_id"));
                category.setCategoryName(resultSet.getString("category_name"));
                category.setDescription(resultSet.getString("description"));
                category.setCreatedAt(resultSet.getTimestamp("created_at"));
                category.setUpdatedAt(resultSet.getTimestamp("updated_at"));
                
                System.out.println("Found category: " + category.getCategoryName()); // Debug log
                categories.add(category);
            }
        } catch (SQLException e) {
            System.err.println("Error fetching categories: " + e.getMessage());
            e.printStackTrace();
        }
        return categories;
    }

    // Get category by ID
    public Category getCategoryById(int categoryId) {
        String sql = "SELECT * FROM items WHERE category_id = ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setInt(1, categoryId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    Category category = new Category();
                    category.setCategoryId(resultSet.getInt("category_id"));
                    category.setCategoryName(resultSet.getString("category_name"));
                    category.setDescription(resultSet.getString("description"));
                    category.setCreatedAt(resultSet.getTimestamp("created_at"));
                    category.setUpdatedAt(resultSet.getTimestamp("updated_at"));
                    return category;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Search categories by name
    public List<Category> searchCategories(String keyword) {
        List<Category> categories = new ArrayList<>();
        String sql = "SELECT * FROM items WHERE category_name LIKE ?";
        try (PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, "%" + keyword + "%");
            try (ResultSet resultSet = statement.executeQuery()) {
                while (resultSet.next()) {
                    Category category = new Category();
                    category.setCategoryId(resultSet.getInt("category_id"));
                    category.setCategoryName(resultSet.getString("category_name"));
                    category.setDescription(resultSet.getString("description"));
                    category.setCreatedAt(resultSet.getTimestamp("created_at"));
                    category.setUpdatedAt(resultSet.getTimestamp("updated_at"));
                    categories.add(category);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return categories;
    }
}