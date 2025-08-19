package dao;

import model.Category;
import org.junit.*;

import java.sql.*;
import java.util.List;

import static org.junit.Assert.*;

public class CategoryDAOTest {

    private static Connection h2Conn;
    private CategoryDAO categoryDAO;

    @BeforeClass
    public static void setupClass() throws Exception {
        // Load H2 driver and create in-memory DB
        Class.forName("org.h2.Driver");
        h2Conn = DriverManager.getConnection(
                "jdbc:h2:mem:testdb;MODE=MySQL;DB_CLOSE_DELAY=-1", "sa", "");

        // Create items table
        try (Statement st = h2Conn.createStatement()) {
            st.execute("CREATE TABLE items (" +
                    "category_id INT AUTO_INCREMENT PRIMARY KEY," +
                    "category_name VARCHAR(255) NOT NULL," +
                    "description VARCHAR(255)," +
                    "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP," +
                    "updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP)");
        }
    }

    @AfterClass
    public static void tearDownClass() throws Exception {
        if (h2Conn != null && !h2Conn.isClosed()) h2Conn.close();
    }

    @Before
    public void setUp() throws Exception {
        // Inject H2 connection into DAO
        categoryDAO = new CategoryDAO(h2Conn);

        // Clean table before each test
        try (Statement st = h2Conn.createStatement()) {
            st.execute("DELETE FROM items");
        }
    }

    @Test
    public void testAddCategory() {
        Category cat = new Category("Laptop", "Electronic devices");
        assertTrue(categoryDAO.addCategory(cat));

        List<Category> list = categoryDAO.getAllCategories();
        assertEquals(1, list.size());
        assertEquals("Laptop", list.get(0).getCategoryName());
    }

    @Test
    public void testUpdateCategory() {
        Category cat = new Category("Laptop", "Electronic devices");
        categoryDAO.addCategory(cat);

        Category c = categoryDAO.getAllCategories().get(0);
        c.setCategoryName("Desktop");
        c.setDescription("Updated description");

        assertTrue(categoryDAO.updateCategory(c));

        Category updated = categoryDAO.getCategoryById(c.getCategoryId());
        assertEquals("Desktop", updated.getCategoryName());
        assertEquals("Updated description", updated.getDescription());
    }

    @Test
    public void testDeleteCategory() {
        Category cat = new Category("Laptop", "Electronic devices");
        categoryDAO.addCategory(cat);

        Category c = categoryDAO.getAllCategories().get(0);
        assertTrue(categoryDAO.deleteCategory(c.getCategoryId()));

        assertEquals(0, categoryDAO.getAllCategories().size());
    }

    @Test
    public void testSearchCategory() {
        categoryDAO.addCategory(new Category("Laptop", "Electronic"));
        categoryDAO.addCategory(new Category("Desktop", "Electronic"));

        List<Category> result = categoryDAO.searchCategories("top");
        assertEquals(2, result.size());

        result = categoryDAO.searchCategories("Lap");
        assertEquals(1, result.size());
        assertEquals("Laptop", result.get(0).getCategoryName());
    }
}
