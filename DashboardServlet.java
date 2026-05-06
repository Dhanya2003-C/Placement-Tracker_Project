package servlet;

import dao.ApplicationDAO;
import dao.QuizDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {

    private ApplicationDAO appDAO  = new ApplicationDAO();
    private QuizDAO        quizDAO = new QuizDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        User user   = (User) session.getAttribute("loggedUser");
        int  userId = user.getId();

        // Application counts
        int totalApps  = appDAO.countByStatus(userId, "applied")
                       + appDAO.countByStatus(userId, "interview")
                       + appDAO.countByStatus(userId, "selected")
                       + appDAO.countByStatus(userId, "rejected");

        // Quiz best scores per topic
        int dsaScore      = quizDAO.getBestScore(userId, "DSA");
        int aptScore      = quizDAO.getBestScore(userId, "Aptitude");
        int hrScore       = quizDAO.getBestScore(userId, "HR");
        int codingScore   = quizDAO.getBestScore(userId, "Coding");

        // Convert score out of 10 to percentage
        int dsaPercent    = dsaScore    * 10;
        int aptPercent    = aptScore    * 10;
        int hrPercent     = hrScore     * 10;
        int codingPercent = codingScore * 10;

        // Calculate overall quiz average
        int quizAvg = (dsaPercent + aptPercent + hrPercent + codingPercent) / 4;

        // Smart tip based on weakest topic
        String weakTopic = "DSA";
        int    weakScore = dsaPercent;
        if (aptPercent    < weakScore) { weakScore = aptPercent;    weakTopic = "Aptitude"; }
        if (hrPercent     < weakScore) { weakScore = hrPercent;     weakTopic = "HR"; }
        if (codingPercent < weakScore) { weakScore = codingPercent; weakTopic = "Coding"; }

        String smartTip;
        if (quizAvg == 0) {
            smartTip = "Welcome " + user.getFullName()
                     + "! Start with a quiz to know your strengths!";
        } else if (weakScore < 40) {
            smartTip = "Your " + weakTopic
                     + " score is low — try 1 practice problem today!";
        } else if (weakScore < 70) {
            smartTip = "You are improving in " + weakTopic
                     + " — keep going!";
        } else {
            smartTip = "Great work " + user.getFullName()
                     + "! You are doing well across all topics!";
        }

        // Recent applications
        List applications = appDAO.getApplicationsByUser(userId);
        List recentApps   = applications.size() > 3
                          ? applications.subList(0, 3)
                          : applications;

        request.setAttribute("user",         user);
        request.setAttribute("totalApps",    totalApps);
        request.setAttribute("quizAvg",      quizAvg);
        request.setAttribute("dsaPercent",   dsaPercent);
        request.setAttribute("aptPercent",   aptPercent);
        request.setAttribute("hrPercent",    hrPercent);
        request.setAttribute("codingPercent",codingPercent);
        request.setAttribute("smartTip",     smartTip);
        request.setAttribute("recentApps",   recentApps);

        request.getRequestDispatcher("/jsp/dashboard.jsp")
               .forward(request, response);
    }
}