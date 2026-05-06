<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.User" %>
<%@ page import="model.Application" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard — Placement Tracker</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/dashboard.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    User   user         = (User)    request.getAttribute("user");
    int    totalApps    = (Integer) request.getAttribute("totalApps");
    int    quizAvg      = (Integer) request.getAttribute("quizAvg");
    int    dsaPercent   = (Integer) request.getAttribute("dsaPercent");
    int    aptPercent   = (Integer) request.getAttribute("aptPercent");
    int    hrPercent    = (Integer) request.getAttribute("hrPercent");
    int    codingPercent= (Integer) request.getAttribute("codingPercent");
    String smartTip     = (String)  request.getAttribute("smartTip");
    List   recentApps   = (List)    request.getAttribute("recentApps");

    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
        return;
    }
%>

<div class="dashboard-wrapper">

    <div class="smart-tip">
        <%= smartTip %>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <div class="stat-number"><%= user.getXp() %></div>
            <div class="stat-label">XP Earned</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= user.getStreak() %></div>
            <div class="stat-label">Day Streak</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= totalApps %></div>
            <div class="stat-label">Apps Sent</div>
        </div>
        <div class="stat-card">
            <div class="stat-number"><%= quizAvg %>%</div>
            <div class="stat-label">Quiz Average</div>
        </div>
    </div>

    <div class="quick-links">
        <a href="<%= request.getContextPath() %>/tracker"
           class="quick-link">
            <div class="quick-link-icon"
                 style="background:#eef0ff; color:#3b4cca;">
                <svg width="20" height="20" viewBox="0 0 24 24"
                     fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M9 11l3 3L22 4"/>
                    <path d="M21 12v7a2 2 0 01-2 2H5a2 2 0
                             01-2-2V5a2 2 0 012-2h11"/>
                </svg>
            </div>
            <div class="quick-link-label">Applications</div>
        </a>
        <a href="<%= request.getContextPath() %>/quiz"
           class="quick-link">
            <div class="quick-link-icon"
                 style="background:#f0fff4; color:#2e7d32;">
                <svg width="20" height="20" viewBox="0 0 24 24"
                     fill="none" stroke="currentColor" stroke-width="2">
                    <circle cx="12" cy="12" r="10"/>
                    <path d="M9.09 9a3 3 0 015.83 1c0 2-3 3-3 3"/>
                    <line x1="12" y1="17" x2="12.01" y2="17"/>
                </svg>
            </div>
            <div class="quick-link-label">Quiz</div>
        </a>
        <a href="<%= request.getContextPath() %>/practice"
           class="quick-link">
            <div class="quick-link-icon"
                 style="background:#fff8e1; color:#e65100;">
                <svg width="20" height="20" viewBox="0 0 24 24"
                     fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M2 3h6a4 4 0 014 4v14a3 3 0 00-3-3H2z"/>
                    <path d="M22 3h-6a4 4 0 00-4 4v14a3 3 0 013-3h7z"/>
                </svg>
            </div>
            <div class="quick-link-label">Practice</div>
        </a>
        <a href="<%= request.getContextPath() %>/leaderboard"
           class="quick-link">
            <div class="quick-link-icon"
                 style="background:#fff0f0; color:#c62828;">
                <svg width="20" height="20" viewBox="0 0 24 24"
                     fill="none" stroke="currentColor" stroke-width="2">
                    <path d="M17 21v-2a4 4 0 00-4-4H5a4 4 0 00-4 4v2"/>
                    <circle cx="9" cy="7" r="4"/>
                    <path d="M23 21v-2a4 4 0 00-3-3.87"/>
                    <path d="M16 3.13a4 4 0 010 7.75"/>
                </svg>
            </div>
            <div class="quick-link-label">Leaderboard</div>
        </a>
    </div>

    <div class="dashboard-row">

        <div class="dash-card">
            <h3>Recent Applications</h3>
            <% if (recentApps == null || recentApps.isEmpty()) { %>
                <p style="font-size:13px; color:#aaa;
                          text-align:center; padding:20px 0;">
                    No applications yet.
                    <a href="<%= request.getContextPath() %>/tracker">
                        Add one now
                    </a>
                </p>
            <% } else {
                for (Object obj : recentApps) {
                    Application app = (Application) obj;
                    String badgeColor =
                        "selected".equals(app.getStatus())  ? "badge-green"  :
                        "interview".equals(app.getStatus()) ? "badge-orange" :
                        "rejected".equals(app.getStatus())  ? "badge-red"    :
                                                               "badge-blue";
            %>
                <div class="app-item">
                    <div>
                        <div class="app-company">
                            <%= app.getCompanyName() %>
                        </div>
                        <div class="app-role"><%= app.getRole() %></div>
                    </div>
                    <span class="badge <%= badgeColor %>">
                        <%= app.getStatus() %>
                    </span>
                </div>
            <%  }
               } %>
        </div>

        <div class="dash-card">
            <h3>Topic Strength</h3>

            <div class="bar-item">
                <div class="bar-header">
                    <span>DSA</span>
                    <span><%= dsaPercent %>%</span>
                </div>
                <div class="bar-track">
                    <div class="bar-fill"
                         data-width="<%= dsaPercent %>"></div>
                </div>
            </div>

            <div class="bar-item">
                <div class="bar-header">
                    <span>Aptitude</span>
                    <span><%= aptPercent %>%</span>
                </div>
                <div class="bar-track">
                    <div class="bar-fill"
                         data-width="<%= aptPercent %>"></div>
                </div>
            </div>

            <div class="bar-item">
                <div class="bar-header">
                    <span>HR</span>
                    <span><%= hrPercent %>%</span>
                </div>
                <div class="bar-track">
                    <div class="bar-fill"
                         data-width="<%= hrPercent %>"></div>
                </div>
            </div>

            <div class="bar-item">
                <div class="bar-header">
                    <span>Coding</span>
                    <span><%= codingPercent %>%</span>
                </div>
                <div class="bar-track">
                    <div class="bar-fill"
                         data-width="<%= codingPercent %>"></div>
                </div>
            </div>

        </div>
    </div>

</div>

<script src="<%= request.getContextPath() %>/js/navbar.js"></script>
<script src="<%= request.getContextPath() %>/js/dashboard.js"></script>
</body>
</html>