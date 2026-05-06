<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Leaderboard — Placement Tracker</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/leaderboard.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    List<Map<String, Object>> leaders =
        (List<Map<String, Object>>) request.getAttribute("leaders");
    int userRank      = (Integer) request.getAttribute("userRank");
    int userWeeklyXp  = (Integer) request.getAttribute("userWeeklyXp");
    int currentUserId = (Integer) session.getAttribute("userId");
    String currentUserName = (String) session.getAttribute("userName");

    int maxXp = 1;
    if (leaders != null && !leaders.isEmpty()) {
        maxXp = (Integer) leaders.get(0).get("weeklyXp");
        if (maxXp == 0) maxXp = 1;
    }
%>

<div class="leaderboard-wrapper">

    <div class="leaderboard-header">
        <h2>Weekly Leaderboard</h2>
        <p>Top performers this week — based on quiz XP earned</p>
    </div>

    <div class="your-rank-card">
        <div>
            <div class="your-rank-label">Your rank this week</div>
            <div style="font-size:20px; font-weight:700; margin:4px 0;">
                <%= currentUserName %>
            </div>
            <div class="your-xp"><%= userWeeklyXp %> XP earned this week</div>
        </div>
        <div class="your-rank-num">#<%= userRank %></div>
    </div>

    <%
    if (leaders == null || leaders.isEmpty()) {
    %>
        <div class="leader-card">
            <div class="empty-leaderboard">
                No quiz activity this week yet.<br>
                Take a quiz to appear on the leaderboard!<br><br>
                <a href="<%= request.getContextPath() %>/quiz"
                   class="take-quiz-btn">Take a Quiz</a>
            </div>
        </div>
    <%
    } else {
    %>

        <%
        if (leaders.size() >= 3) {
            Map<String, Object> first  = leaders.get(0);
            Map<String, Object> second = leaders.get(1);
            Map<String, Object> third  = leaders.get(2);
        %>
        <div class="top-three">

            <div class="podium-card">
                <div class="podium-rank">🥈</div>
                <div class="podium-avatar" style="background:#95a5a6;">
                    <%= second.get("fullName").toString().substring(0,1).toUpperCase() %>
                </div>
                <div class="podium-name"><%= second.get("fullName") %></div>
                <div class="podium-xp"><%= second.get("weeklyXp") %> XP</div>
            </div>

            <div class="podium-card first">
                <div class="podium-rank">🥇</div>
                <div class="podium-avatar" style="background:#f39c12;">
                    <%= first.get("fullName").toString().substring(0,1).toUpperCase() %>
                </div>
                <div class="podium-name"><%= first.get("fullName") %></div>
                <div class="podium-xp"><%= first.get("weeklyXp") %> XP</div>
            </div>

            <div class="podium-card">
                <div class="podium-rank">🥉</div>
                <div class="podium-avatar" style="background:#cd7f32;">
                    <%= third.get("fullName").toString().substring(0,1).toUpperCase() %>
                </div>
                <div class="podium-name"><%= third.get("fullName") %></div>
                <div class="podium-xp"><%= third.get("weeklyXp") %> XP</div>
            </div>

        </div>
        <%
        }
        %>

        <div class="leader-card">
        <%
            for (Map<String, Object> leader : leaders) {
                int     rankNum    = (Integer) leader.get("rankNum");
                int     leaderId   = (Integer) leader.get("id");
                String  leaderName = (String)  leader.get("fullName");
                String  leaderType = (String)  leader.get("userType");
                int     leaderXp   = (Integer) leader.get("weeklyXp");
                boolean isMe       = (leaderId == currentUserId);
                String  rankClass  = rankNum == 1 ? "rank-1" :
                                     rankNum == 2 ? "rank-2" :
                                     rankNum == 3 ? "rank-3" : "";
                int     barWidth   = (leaderXp * 100) / maxXp;
        %>
            <div class="leader-row <%= isMe ? "is-me" : "" %>">
                <div class="rank-num <%= rankClass %>">
                    <%
                    if (rankNum == 1) { %>🥇<%
                    } else if (rankNum == 2) { %>🥈<%
                    } else if (rankNum == 3) { %>🥉<%
                    } else { %><%= rankNum %><%
                    }
                    %>
                </div>
                <div class="leader-avatar <%= isMe ? "me" : "" %>">
                    <%= leaderName.substring(0,1).toUpperCase() %>
                </div>
                <div class="leader-info">
                    <div class="leader-name">
                        <%= leaderName %>
                        <% if (isMe) { %>
                            <span style="font-size:11px; background:#eef0ff;
                                         color:#3b4cca; padding:2px 8px;
                                         border-radius:10px; margin-left:4px;
                                         font-weight:500;">You</span>
                        <% } %>
                    </div>
                    <div class="leader-type"><%= leaderType %></div>
                </div>
                <div class="leader-xp-bar">
                    <div class="leader-xp-num"><%= leaderXp %></div>
                    <div class="leader-xp-label">XP</div>
                    <div class="mini-bar-track">
                        <div class="mini-bar-fill"
                             style="width:<%= barWidth %>%"></div>
                    </div>
                </div>
            </div>
        <%
            }
        %>
        </div>

    <%
    }
    %>

    <div style="text-align:center; margin-top:24px;">
        <a href="<%= request.getContextPath() %>/quiz"
           class="take-quiz-btn">
            Take a Quiz to Earn More XP
        </a>
    </div>

</div>

<script src="<%= request.getContextPath() %>/js/navbar.js"></script>
</body>
</html>