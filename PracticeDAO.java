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

public class PracticeDAO {

    public List<Map<String, Object>> getProblemsWithProgress(
            int userId, String topic) {

        List<Map<String, Object>> list =
            new ArrayList<Map<String, Object>>();

        String sql = "SELECT pp.id, pp.title, pp.difficulty, pp.link, " +
                     "IFNULL(pr.solved, false) as solved " +
                     "FROM practice_problems pp " +
                     "LEFT JOIN practice_progress pr " +
                     "ON pp.id = pr.problem_id AND pr.user_id = ? " +
                     "WHERE pp.topic = ? ORDER BY " +
                     "FIELD(pp.difficulty,'easy','medium','hard')";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, topic);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<String, Object>();
                row.put("id",         rs.getInt("id"));
                row.put("title",      rs.getString("title"));
                row.put("difficulty", rs.getString("difficulty"));
                row.put("link",       rs.getString("link"));
                row.put("solved",     rs.getBoolean("solved"));
                list.add(row);
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("Get problems error: " + e.getMessage());
        }
        return list;
    }

    public boolean markSolved(int userId, int problemId) {
        String checkSql = "SELECT id FROM practice_progress " +
                          "WHERE user_id = ? AND problem_id = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement check = con.prepareStatement(checkSql);
            check.setInt(1, userId);
            check.setInt(2, problemId);
            ResultSet rs = check.executeQuery();

            if (rs.next()) {
                String updateSql = "UPDATE practice_progress " +
                                   "SET solved = true, solved_on = NOW() " +
                                   "WHERE user_id = ? AND problem_id = ?";
                PreparedStatement update = con.prepareStatement(updateSql);
                update.setInt(1, userId);
                update.setInt(2, problemId);
                update.executeUpdate();
            } else {
                String insertSql = "INSERT INTO practice_progress " +
                                   "(user_id, problem_id, solved, solved_on) " +
                                   "VALUES (?, ?, true, NOW())";
                PreparedStatement insert = con.prepareStatement(insertSql);
                insert.setInt(1, userId);
                insert.setInt(2, problemId);
                insert.executeUpdate();
            }
            con.close();
            return true;
        } catch (SQLException e) {
            System.out.println("Mark solved error: " + e.getMessage());
            return false;
        }
    }

    public boolean markUnsolved(int userId, int problemId) {
        String sql = "UPDATE practice_progress SET solved = false " +
                     "WHERE user_id = ? AND problem_id = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setInt(2, problemId);
            ps.executeUpdate();
            con.close();
            return true;
        } catch (SQLException e) {
            System.out.println("Mark unsolved error: " + e.getMessage());
            return false;
        }
    }

    public int getSolvedCount(int userId, String topic) {
        String sql = "SELECT COUNT(*) FROM practice_progress pr " +
                     "JOIN practice_problems pp ON pr.problem_id = pp.id " +
                     "WHERE pr.user_id = ? AND pp.topic = ? " +
                     "AND pr.solved = true";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, topic);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                con.close();
                return count;
            }
        } catch (SQLException e) {
            System.out.println("Solved count error: " + e.getMessage());
        }
        return 0;
    }

    public int getTotalCount(String topic) {
        String sql = "SELECT COUNT(*) FROM practice_problems " +
                     "WHERE topic = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, topic);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int count = rs.getInt(1);
                con.close();
                return count;
            }
        } catch (SQLException e) {
            System.out.println("Total count error: " + e.getMessage());
        }
        return 0;
    }

    public List<String> getAvailableTopics() {
        List<String> topics = new ArrayList<String>();
        String sql = "SELECT DISTINCT topic FROM practice_problems";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                topics.add(rs.getString("topic"));
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("Get topics error: " + e.getMessage());
        }
        return topics;
    }
}