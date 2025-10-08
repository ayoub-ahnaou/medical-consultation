package com.medicale.consultation.consultationmedicale.utils;


import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtils {

    public static String hashPassword(String password) {
        // implementation of hashing password using bcrypt
        return BCrypt.hashpw(password, BCrypt.gensalt(12));
    }

    public static boolean checkPassword(String password, String hashedPassword) {
        // implementation of comparing two passwords
        if (password == null || hashedPassword == null) {
            return false;
        }
        return BCrypt.checkpw(password, hashedPassword);
    }
}
