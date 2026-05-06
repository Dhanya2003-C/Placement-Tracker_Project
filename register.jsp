<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — Placement Tracker</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/auth.css">
</head>
<body>

<div class="auth-wrapper">
    <div class="auth-container">

        <div class="auth-logo">
            <h1>Placement Tracker</h1>
            <p>Your personal job preparation companion</p>
        </div>

        <% String error = (String) request.getAttribute("error");
           if (error != null) { %>
            <div class="error-box"><%= error %></div>
        <% } %>

        <form action="<%= request.getContextPath() %>/register"
              method="post" id="registerForm">

            <div class="form-group">
                <label for="fullName">Full Name</label>
                <input type="text" id="fullName" name="fullName"
                       placeholder="Enter your full name" required />
                <span class="field-error" id="nameError"></span>
            </div>

            <div class="form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" name="email"
                       placeholder="Enter your email" required />
                <span class="field-error" id="emailError"></span>
            </div>

            <div class="form-group">
                <label for="passwordInput">Password</label>
                <div class="password-wrapper">
                    <input type="password" id="passwordInput" name="password"
                           placeholder="Create a password" required />
                    <button type="button" class="toggle-pwd"
                            id="togglePwd">Show</button>
                </div>
                <div class="strength-bar">
                    <div class="strength-fill" id="strengthFill"></div>
                </div>
                <span class="strength-text" id="strengthText"></span>
            </div>

            <div class="form-group">
                <label>I am a...</label>
                <div class="user-type-grid">
                    <input type="radio" name="userType"
                           id="student" value="student" required />
                    <label for="student" class="type-card">Student</label>

                    <input type="radio" name="userType"
                           id="fresher" value="fresher" />
                    <label for="fresher" class="type-card">Fresher</label>

                    <input type="radio" name="userType"
                           id="experienced" value="experienced" />
                    <label for="experienced" class="type-card">Experienced</label>
                </div>
                <span class="field-error" id="typeError"></span>
            </div>

            <button type="submit" class="btn-auth">Create Account</button>

        </form>

        <p class="auth-footer">
            Already have an account?
            <a href="<%= request.getContextPath() %>/jsp/login.jsp">
                Login here
            </a>
        </p>

    </div>
</div>

<script src="<%= request.getContextPath() %>/js/auth.js"></script>
</body>
</html>