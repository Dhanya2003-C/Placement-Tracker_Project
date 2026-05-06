package servlet;


import dao.*;
import model.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    // GET - show the registration form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
    }

    // POST - handle form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName").trim();
        String email    = request.getParameter("email").trim();
        String password = request.getParameter("password").trim();
        String userType = request.getParameter("userType");

        // Basic validation
        if (fullName.isEmpty() || email.isEmpty() || password.isEmpty() || userType == null) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        // Check if email already registered
        if (userDAO.emailExists(email)) {
            request.setAttribute("error", "This email is already registered. Please login.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
            return;
        }

        // Save user
        User user = new User(fullName, email, password, userType);
        boolean success = userDAO.registerUser(user);

        if (success) {
            response.sendRedirect(request.getContextPath() + "/success.html");
        } else {
            request.setAttribute("error", "Something went wrong. Please try again.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }
}