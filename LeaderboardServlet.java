package servlet;

import dao.LeaderboardDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/leaderboard")
public class LeaderboardServlet extends HttpServlet {

    private LeaderboardDAO leaderboardDAO = new LeaderboardDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(
                request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        List<Map<String, Object>> leaders =
            leaderboardDAO.getWeeklyLeaderboard();
        int userRank    = leaderboardDAO.getUserRank(userId);
        int userWeeklyXp = leaderboardDAO.getUserWeeklyXp(userId);

        request.setAttribute("leaders",      leaders);
        request.setAttribute("userRank",     userRank);
        request.setAttribute("userWeeklyXp", userWeeklyXp);

        request.getRequestDispatcher("/jsp/leaderboard.jsp")
               .forward(request, response);
    }
}