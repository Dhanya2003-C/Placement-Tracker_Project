<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String userName = (String) session.getAttribute("userName");
    int    xp       = 0;
    model.User u =
        (model.User) session.getAttribute("loggedUser");
    if (u != null) xp = u.getXp();
%>
<nav class="navbar">
    <a href="<%= request.getContextPath() %>/dashboard"
       class="navbar-brand">Placement Tracker</a>

    <div class="navbar-links">
        <a href="<%= request.getContextPath() %>/dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/tracker">Applications</a>
        <a href="<%= request.getContextPath() %>/quiz">Quiz</a>
        <a href="<%= request.getContextPath() %>/practice">Practice</a>
        <a href="<%= request.getContextPath() %>/leaderboard">Leaderboard</a>
    </div>

    <div class="navbar-user">
        <span class="navbar-xp"><%= xp %> XP</span>
        <div class="navbar-avatar">
            <%= userName != null ? userName.substring(0,1).toUpperCase() : "U" %>
        </div>
        <span><%= userName != null ? userName : "User" %></span>
        <a href="<%= request.getContextPath() %>/logout"
           class="navbar-logout">Logout</a>
    </div>
</nav>