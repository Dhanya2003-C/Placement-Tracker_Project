package dao;

import model.*;
import com.*;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    // Register new user
    public boolean registerUser(User user) {
        String sql = "INSERT INTO users1 (full_name, email, password, user_type) VALUES (?, ?, ?, ?)";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);

            String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, hashedPassword);
            ps.setString(4, user.getUserType());

            int rows = ps.executeUpdate();
            con.close();
            return rows > 0;

        } catch (SQLException e) {
            System.out.println("Register error: " + e.getMessage());
            return false;
        }
    }

    // Check if email already exists
    public boolean emailExists(String email) {
        String sql = "SELECT id FROM users1 WHERE email = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            boolean exists = rs.next();
            con.close();
            return exists;
        } catch (SQLException e) {
            System.out.println("Email check error: " + e.getMessage());
            return false;
        }
    }

    // Login - verify email and password
    public User loginUser(String email, String password) {
        String sql = "SELECT * FROM users1 WHERE email = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String storedHash = rs.getString("password");
                if (BCrypt.checkpw(password, storedHash)) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setUserType(rs.getString("user_type"));
                    user.setXp(rs.getInt("xp"));
                    user.setStreak(rs.getInt("streak"));
                    con.close();
                    return user;
                }
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("Login error: " + e.getMessage());
        }
        return null;
    }
}
