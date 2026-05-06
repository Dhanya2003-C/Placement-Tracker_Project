<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz Result — Placement Tracker</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/quiz.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    int score    = (Integer) request.getAttribute("score");
    int total    = (Integer) request.getAttribute("total");
    String topic = (String)  request.getAttribute("topic");
    int percent  = (score * 100) / total;
    String grade = percent >= 80 ? "Excellent!" :
                   percent >= 60 ? "Good job!"  :
                   percent >= 40 ? "Keep practicing!" :
                                   "Needs improvement!";
    String gradeColor = percent >= 80 ? "#2e7d32" :
                        percent >= 60 ? "#3b4cca" :
                        percent >= 40 ? "#e65100" :
                                        "#c0392b";
%>

<div class="quiz-wrapper" style="text-align:center;">

    <div class="quiz-card" style="max-width:440px; margin:0 auto;">

        <div style="width:100px; height:100px; border-radius:50%;
                    background:#f8f9ff; border:4px solid <%= gradeColor %>;
                    display:flex; align-items:center; justify-content:center;
                    margin:0 auto 20px; flex-direction:column;">
            <div style="font-size:28px; font-weight:700;
                        color:<%= gradeColor %>;">
                <%= score %>/<%= total %>
            </div>
        </div>

        <h2 style="font-size:20px; font-weight:700; color:#1a1a2e;
                   margin-bottom:8px;"><%= grade %></h2>

        <p style="font-size:14px; color:#888; margin-bottom:24px;">
            You scored <%= percent %>% in <%= topic %>
        </p>

        <div style="background:#f8f9ff; border-radius:12px; padding:16px;
                    margin-bottom:24px;">
            <div style="display:flex; justify-content:space-between;
                        font-size:13px; padding:6px 0;
                        border-bottom:0.5px solid #eee;">
                <span style="color:#888;">Topic</span>
                <span style="font-weight:600;"><%= topic %></span>
            </div>
            <div style="display:flex; justify-content:space-between;
                        font-size:13px; padding:6px 0;
                        border-bottom:0.5px solid #eee;">
                <span style="color:#888;">Score</span>
                <span style="font-weight:600;
                             color:<%= gradeColor %>;">
                    <%= score %> / <%= total %>
                </span>
            </div>
            <div style="display:flex; justify-content:space-between;
                        font-size:13px; padding:6px 0;">
                <span style="color:#888;">Percentage</span>
                <span style="font-weight:600;
                             color:<%= gradeColor %>;">
                    <%= percent %>%
                </span>
            </div>
        </div>

        <div style="display:flex; gap:10px; justify-content:center;">
            <a href="<%= request.getContextPath() %>/quiz?topic=<%= topic %>"
               class="btn-primary"
               style="text-decoration:none; padding:11px 20px;">
                Try Again
            </a>
            <a href="<%= request.getContextPath() %>/quiz"
               class="btn-outline"
               style="text-decoration:none; padding:11px 20px;">
                Other Topics
            </a>
            <a href="<%= request.getContextPath() %>/dashboard"
               class="btn-outline"
               style="text-decoration:none; padding:11px 20px;">
                Dashboard
            </a>
        </div>

    </div>
</div>

<script src="<%= request.getContextPath() %>/js/navbar.js"></script>
</body>
</html>