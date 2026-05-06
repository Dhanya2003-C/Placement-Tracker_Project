package servlet;

import dao.PracticeDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet("/practice")
public class PracticeServlet extends HttpServlet {

    private PracticeDAO practiceDAO = new PracticeDAO();

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
        String topic = request.getParameter("topic");

        if (topic == null) {
            List<String> topics = practiceDAO.getAvailableTopics();
            request.setAttribute("topics", topics);
            request.getRequestDispatcher("/jsp/practice-topics.jsp")
                   .forward(request, response);
        } else {
            List<Map<String, Object>> problems =
                practiceDAO.getProblemsWithProgress(userId, topic);
            int solved = practiceDAO.getSolvedCount(userId, topic);
            int total  = practiceDAO.getTotalCount(topic);

            request.setAttribute("problems", problems);
            request.setAttribute("topic",    topic);
            request.setAttribute("solved",   solved);
            request.setAttribute("total",    total);

            request.getRequestDispatcher("/jsp/practice.jsp")
                   .forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(
                request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int    userId    = (Integer) session.getAttribute("userId");
        int    problemId = Integer.parseInt(
                               request.getParameter("problemId"));
        String action    = request.getParameter("action");
        String topic     = request.getParameter("topic");

        if ("solve".equals(action)) {
            practiceDAO.markSolved(userId, problemId);
        } else if ("unsolve".equals(action)) {
            practiceDAO.markUnsolved(userId, problemId);
        }

        response.sendRedirect(
            request.getContextPath() + "/practice?topic=" + topic);
    }
}
