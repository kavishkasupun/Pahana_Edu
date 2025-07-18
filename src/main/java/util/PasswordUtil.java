package util;

import java.security.SecureRandom;
import java.util.Base64;

public class PasswordUtil {
    private static final SecureRandom random = new SecureRandom();
    private static final Base64.Encoder encoder = Base64.getUrlEncoder().withoutPadding();

    public static String generateRandomToken() {
        byte[] buffer = new byte[32];
        random.nextBytes(buffer);
        return encoder.encodeToString(buffer);
    }
}