package dao;

import com.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class LeaderboardDAO {

    public List<Map<String, Object>> getWeeklyLeaderboard() {
        List<Map<String, Object>> list =
            new ArrayList<Map<String, Object>>();
        String sql = "SELECT u.id, u.full_name, u.user_type, " +
                     "COALESCE(SUM(qr.score * 10), 0) as weekly_xp " +
                     "FROM users1 u " +
                     "LEFT JOIN quiz_results qr ON u.id = qr.user_id " +
                     "AND qr.taken_on >= DATE_SUB(NOW(), INTERVAL 7 DAY) " +
                     "GROUP BY u.id, u.full_name, u.user_type " +
                     "ORDER BY weekly_xp DESC " +
                     "LIMIT 10";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            int rankNum = 1;
            while (rs.next()) {
                Map<String, Object> row = new HashMap<String, Object>();
                row.put("rankNum",  rankNum++);
                row.put("id",       rs.getInt("id"));
                row.put("fullName", rs.getString("full_name"));
                row.put("userType", rs.getString("user_type"));
                row.put("weeklyXp", rs.getInt("weekly_xp"));
                list.add(row);
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("Leaderboard error: " + e.getMessage());
        }
        return list;
    }

    public int getUserRank(int userId) {
        String sql = "SELECT COUNT(*) + 1 as userRank " +
                     "FROM ( " +
                     "SELECT u.id, " +
                     "COALESCE(SUM(qr.score * 10), 0) as weekly_xp " +
                     "FROM users1 u " +
                     "LEFT JOIN quiz_results qr ON u.id = qr.user_id " +
                     "AND qr.taken_on >= DATE_SUB(NOW(), INTERVAL 7 DAY) " +
                     "GROUP BY u.id " +
                     ") ranked WHERE weekly_xp > ( " +
                     "SELECT COALESCE(SUM(score * 10), 0) " +
                     "FROM quiz_results " +
                     "WHERE user_id = ? " +
                     "AND taken_on >= DATE_SUB(NOW(), INTERVAL 7 DAY))";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int userRank = rs.getInt("userRank");
                con.close();
                return userRank;
            }
        } catch (SQLException e) {
            System.out.println("User rank error: " + e.getMessage());
        }
        return 0;
    }

    public int getUserWeeklyXp(int userId) {
        String sql = "SELECT COALESCE(SUM(score * 10), 0) as weekly_xp " +
                     "FROM quiz_results " +
                     "WHERE user_id = ? " +
                     "AND taken_on >= DATE_SUB(NOW(), INTERVAL 7 DAY)";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int weeklyXp = rs.getInt("weekly_xp");
                con.close();
                return weeklyXp;
            }
        } catch (SQLException e) {
            System.out.println("Weekly XP error: " + e.getMessage());
        }
        return 0;
    }
}