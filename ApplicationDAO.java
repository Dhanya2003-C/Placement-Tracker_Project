package dao;


import model.Application;
import com.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ApplicationDAO {

    public boolean addApplication(Application app) {
        String sql = "INSERT INTO application (user_id, company_name, role, status, applied_date, notes) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1,    app.getUserId());
            ps.setString(2, app.getCompanyName());
            ps.setString(3, app.getRole());
            ps.setString(4, app.getStatus());
            ps.setString(5, app.getAppliedDate());
            ps.setString(6, app.getNotes());
            int rows = ps.executeUpdate();
            con.close();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Add application error: " + e.getMessage());
            return false;
        }
    }

    public List<Application> getApplicationsByUser(int userId) {
        List<Application> list = new ArrayList<Application>();
        String sql = "SELECT * FROM application WHERE user_id = ? ORDER BY applied_date DESC";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Application app = new Application();
                app.setId(rs.getInt("id"));
                app.setUserId(rs.getInt("user_id"));
                app.setCompanyName(rs.getString("company_name"));
                app.setRole(rs.getString("role"));
                app.setStatus(rs.getString("status"));
                app.setAppliedDate(rs.getString("applied_date"));
                app.setNotes(rs.getString("notes"));
                list.add(app);
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("Get application error: " + e.getMessage());
        }
        return list;
    }

    public boolean updateStatus(int appId, String status) {
        String sql = "UPDATE application SET status = ? WHERE id = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, appId);
            int rows = ps.executeUpdate();
            con.close();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Update status error: " + e.getMessage());
            return false;
        }
    }

    public boolean deleteApplication(int appId) {
        String sql = "DELETE FROM application WHERE id = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, appId);
            int rows = ps.executeUpdate();
            con.close();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Delete application error: " + e.getMessage());
            return false;
        }
    }

    public int countByStatus(int userId, String status) {
        String sql = "SELECT COUNT(*) FROM application WHERE user_id = ? AND status = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                con.close();
                return count;
            }
        } catch (SQLException e) {
            System.out.println("Count error: " + e.getMessage());
        }
        return 0;
    }
}
