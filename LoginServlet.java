
package servlet;

import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email    = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();

        System.out.println("Login attempt: " + email);

        if (email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
            return;
        }

        User user = userDAO.loginUser(email, password);

        System.out.println("User found: " + user);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedUser", user);
            session.setAttribute("userId",     user.getId());
            session.setAttribute("userName",   user.getFullName());

            System.out.println("Session created for userId: " + user.getId());
            System.out.println("Redirecting to dashboard...");

            response.sendRedirect(request.getContextPath() + "/dashboard");
        } else {
            System.out.println("Login failed — wrong email or password");
            request.setAttribute("error", "Invalid email or password.");
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
    }
}
