<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — Placement Tracker</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/auth.css">
</head>
<body>

<div class="auth-wrapper">
    <div class="auth-container">

        <div class="auth-logo">
            <h1>Welcome Back!</h1>
            <p>Login to continue your placement journey</p>
        </div>

        <% String registered = request.getParameter("registered");
           if ("true".equals(registered)) { %>
            <div class="success-box">
                Registration successful! Please login.
            </div>
        <% } %>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error-box"><%= error %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/login" method="post">

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="Enter your email" required />
            </div>

            <div class="form-group">
                <label for="password">Password</label>
                <input type="password" id="password" name="password"
                       placeholder="Enter your password" required />
            </div>

            <div class="remember-row">
                <input type="checkbox" id="remember" name="remember" />
                <label for="remember">Remember me</label>
            </div>

            <button type="submit" class="btn-auth">Login</button>

        </form>

        <p class="auth-footer">
            Don't have an account?
            <a href="<%= request.getContextPath() %>/jsp/register.jsp">
                Register here
            </a>
        </p>

    </div>
</div>

</body>
</html>