package servlet;


import dao.ApplicationDAO;
import model.Application;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/tracker")
public class TrackerServlet extends HttpServlet {

    private ApplicationDAO appDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");

        List<Application> apps = appDAO.getApplicationsByUser(userId);

        int applied    = appDAO.countByStatus(userId, "applied");
        int interview  = appDAO.countByStatus(userId, "interview");
        int selected   = appDAO.countByStatus(userId, "selected");
        int rejected   = appDAO.countByStatus(userId, "rejected");

        request.setAttribute("apps",      apps);
        request.setAttribute("applied",   applied);
        request.setAttribute("interview", interview);
        request.setAttribute("selected",  selected);
        request.setAttribute("rejected",  rejected);

        request.getRequestDispatcher("/jsp/tracker.jsp").forward(request, response);
    }  

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String companyName = request.getParameter("companyName").trim();
            String role        = request.getParameter("role").trim();
            String status      = request.getParameter("status");
            String appliedDate = request.getParameter("appliedDate");
            String notes       = request.getParameter("notes").trim();

            Application app = new Application(userId, companyName, role,
                                              status, appliedDate, notes);
            appDAO.addApplication(app);

        } else if ("updateStatus".equals(action)) {
            int    appId  = Integer.parseInt(request.getParameter("appId"));
            String status = request.getParameter("status");
            appDAO.updateStatus(appId, status);

        } else if ("delete".equals(action)) {
            int appId = Integer.parseInt(request.getParameter("appId"));
            appDAO.deleteApplication(appId);
        }

        response.sendRedirect(request.getContextPath() + "/tracker");
    }
}