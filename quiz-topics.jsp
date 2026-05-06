<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quiz — Placement Tracker</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/quiz.css">
</head>
<body>

<%@ include file="/jsp/navbar.jsp" %>

<%
    List<String> topics = (List<String>) request.getAttribute("topics");
%>

<div class="quiz-wrapper">

    <div style="text-align:center; margin-bottom:32px;">
        <h2 style="font-size:22px; font-weight:700; color:#1a1a2e;
                   margin-bottom:8px;">Choose a Topic</h2>
        <p style="font-size:14px; color:#888;">
            10 questions per topic — 30 seconds each
        </p>
    </div>

    <div class="topic-grid">
        <% for (String topic : topics) { %>
            <a href="<%= request.getContextPath() %>/quiz?topic=<%= topic %>"
               class="topic-card">
                <div class="topic-icon"
                     style="background:<%= 
                         "DSA".equals(topic)      ? "#eef0ff" :
                         "Aptitude".equals(topic) ? "#f0fff4" :
                         "HR".equals(topic)       ? "#fff8e1" :
                                                    "#fff0f0"
                     %>; color:<%=
                         "DSA".equals(topic)      ? "#3b4cca" :
                         "Aptitude".equals(topic) ? "#2e7d32" :
                         "HR".equals(topic)       ? "#e65100" :
                                                    "#c62828"
                     %>;">
                    <%= "DSA".equals(topic)      ? "{ }" :
                        "Aptitude".equals(topic) ? "123" :
                        "HR".equals(topic)       ? ":)" :
                                                   "&lt;/&gt;" %>
                </div>
                <div class="topic-name"><%= topic %></div>
                <div class="topic-count">10 questions</div>
            </a>
        <% } %>
    </div>

</div>

<script src="<%= request.getContextPath() %>/js/navbar.js"></script>
</body>
</html>