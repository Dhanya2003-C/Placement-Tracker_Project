package dao;

import model.QuizQuestion;
import com.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class QuizDAO {

    public List<QuizQuestion> getQuestionsByTopic(String topic) {
        List<QuizQuestion> list = new ArrayList<QuizQuestion>();
        String sql = "SELECT * FROM quiz_questions WHERE topic = ? ORDER BY RAND() LIMIT 10";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, topic);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                QuizQuestion q = new QuizQuestion();
                q.setId(rs.getInt("id"));
                q.setTopic(rs.getString("topic"));
                q.setQuestion(rs.getString("question"));
                q.setOptionA(rs.getString("option_a"));
                q.setOptionB(rs.getString("option_b"));
                q.setOptionC(rs.getString("option_c"));
                q.setOptionD(rs.getString("option_d"));
                q.setCorrectOption(rs.getString("correct_option"));
                q.setExplanation(rs.getString("explanation"));
                list.add(q);
            }
            con.close();
        } catch (SQLException e) {
            System.out.println("Get questions error: " + e.getMessage());
        }
        return list;
    }

    public boolean saveResult(int userId, String topic, int score, int total) {
        String sql = "INSERT INTO quiz_results (user_id, topic, score, total) VALUES (?, ?, ?, ?)";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, topic);
            ps.setInt(3, score);
            ps.setInt(4, total);
            int rows = ps.executeUpdate();
            con.close();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("Save result error: " + e.getMessage());
            return false;
        }
    }

    public List<String> getAvailableTopics() {
        List<String> topics = new ArrayList<String>();
        String sql = "SELECT DISTINCT topic FROM quiz_questions";
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

    public int getBestScore(int userId, String topic) {
        String sql = "SELECT MAX(score) FROM quiz_results WHERE user_id = ? AND topic = ?";
        try {
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, userId);
            ps.setString(2, topic);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int score = rs.getInt(1);
                con.close();
                return score;
            }
        } catch (SQLException e) {
            System.out.println("Get best score error: " + e.getMessage());
        }
        return 0;
    }
}