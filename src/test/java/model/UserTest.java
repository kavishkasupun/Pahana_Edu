package model;

import static org.junit.Assert.*;
import org.junit.Test;
import java.sql.Timestamp;

public class UserTest {

    @Test
    public void testUserGettersAndSetters() {
        User user = new User();
        user.setId(1);
        user.setUsername("kavi");
        user.setPassword("12345");
        user.setEmail("test@example.com");
        user.setRole("admin");
        user.setVerified(true);
        Timestamp now = new Timestamp(System.currentTimeMillis());
        user.setCreatedAt(now);

        assertEquals(1, user.getId());
        assertEquals("kavi", user.getUsername());
        assertEquals("12345", user.getPassword());
        assertEquals("test@example.com", user.getEmail());
        assertEquals("admin", user.getRole());
        assertTrue(user.isVerified());
        assertEquals(now, user.getCreatedAt());
    }
}
