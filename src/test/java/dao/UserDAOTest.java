package dao;

import static org.junit.Assert.*;

import java.sql.*;
import java.util.List;

import model.User;
import org.junit.*;

public class UserDAOTest {

    private static Connection connection;
    private UserDAO userDAO;

    @BeforeClass
    public static void initDB() throws Exception {
        Class.forName("org.h2.Driver");
        connection = DriverManager.getConnection("jdbc:h2:mem:testdb;DB_CLOSE_DELAY=-1", "sa", "");

        try (Statement stmt = connection.createStatement()) {
            stmt.execute("CREATE TABLE IF NOT EXISTS users ("
                    + "id INT AUTO_INCREMENT PRIMARY KEY,"
                    + "username VARCHAR(50),"
                    + "email VARCHAR(100),"
                    + "password VARCHAR(50),"
                    + "role VARCHAR(20),"
                    + "verified BOOLEAN DEFAULT FALSE,"
                    + "created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP"
                    + ")");
        }
    }

    @Before
    public void setUp() {
        userDAO = new UserDAO();
        userDAO.setTestConnection(connection);
    }

    @After
    public void cleanUp() throws Exception {
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("DELETE FROM users");
        }
    }

    @AfterClass
    public static void closeDB() throws Exception {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }

    @Test
    public void testAddAndCheckLoginSuccess() {
        User user = new User();
        user.setUsername("john");
        user.setEmail("john@example.com");
        user.setPassword("1234");
        user.setRole("admin");

        assertTrue(userDAO.addUser(user));

        User loggedIn = userDAO.checkLogin("john", "1234");
        assertNotNull(loggedIn);
        assertEquals("john", loggedIn.getUsername());

        User loggedInEmail = userDAO.checkLogin("john@example.com", "1234");
        assertNotNull(loggedInEmail);
        assertEquals("john@example.com", loggedInEmail.getEmail());
    }

    @Test
    public void testCheckLoginInvalid() {
        User result = userDAO.checkLogin("invalid", "wrong");
        assertNull(result);
    }

    @Test
    public void testEmailExists() {
        User user = new User();
        user.setUsername("sara");
        user.setEmail("sara@example.com");
        user.setPassword("pass");
        user.setRole("cashier");
        userDAO.addUser(user);

        assertTrue(userDAO.emailExists("sara@example.com"));
        assertFalse(userDAO.emailExists("notfound@example.com"));
    }

    @Test
    public void testGetAllUsers() {
        User user1 = new User();
        user1.setUsername("alex");
        user1.setEmail("alex@example.com");
        user1.setPassword("pass");
        user1.setRole("cashier");
        userDAO.addUser(user1);

        User user2 = new User();
        user2.setUsername("bob");
        user2.setEmail("bob@example.com");
        user2.setPassword("pass2");
        user2.setRole("admin");
        userDAO.addUser(user2);

        List<User> users = userDAO.getAllUsers();
        assertEquals(2, users.size());
        assertEquals("alex", users.get(0).getUsername());
        assertEquals("bob", users.get(1).getUsername());
    }

    @Test
    public void testDeleteUser() {
        User user = new User();
        user.setUsername("mike");
        user.setEmail("mike@example.com");
        user.setPassword("pass");
        user.setRole("cashier");
        userDAO.addUser(user);

        List<User> usersBefore = userDAO.getAllUsers();
        assertEquals(1, usersBefore.size());

        int id = usersBefore.get(0).getId();
        assertTrue(userDAO.deleteUser(id));

        List<User> usersAfter = userDAO.getAllUsers();
        assertTrue(usersAfter.isEmpty());
    }
}
