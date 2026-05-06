<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Practice — Placement Tracker</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/navbar.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/quiz.css">
</head>
<body>

<%@ include file="navbar.jsp" %>

<%
    List<Map<String, Object>> problems =
        (List<Map<String, Object>>) request.getAttribute("problems");
    String topic  = (String)  request.getAttribute("topic");
    int    solved = (Integer) request.getAttribute("solved");
    int    total  = (Integer) request.getAttribute("total");
    int    pct    = total > 0 ? (solved * 100) / total : 0;
%>

<div class="practice-wrapper">

    <div class="practice-header">
        <div class="practice-title"><%= topic %> Practice</div>
        <div class="practice-count"><%= solved %> / <%= total %> solved</div>
    </div>

    <div class="practice-bar">
        <div class="practice-bar-fill"
             style="width:<%= pct %>%"></div>
    </div>

    <div style="margin-bottom:14px;">
        <a href="<%= request.getContextPath() %>/practice"
           style="font-size:13px; color:#888; text-decoration:none;">
            ← Back to topics
        </a>
    </div>

    <div class="problem-list">
        <% for (Map<String, Object> problem : problems) {
            boolean isSolved = (Boolean) problem.get("solved");
            String diff      = (String)  problem.get("difficulty");
            String diffClass = "easy".equals(diff)   ? "diff-easy"   :
                               "medium".equals(diff) ? "diff-medium" :
                                                       "diff-hard";
        %>
        <div class="problem-item">
            <div class="problem-left">
                <div class="problem-check <%= isSolved ? "solved" : "" %>">
                </div>
                <div>
                    <a href="<%= problem.get("link") %>"
                       target="_blank"
                       class="problem-title
                              <%= isSolved ? "solved-text" : "" %>"
                       style="text-decoration:none; color:inherit;">
                        <%= problem.get("title") %>
                    </a>
                </div>
            </div>
            <div style="display:flex; align-items:center; gap:10px;">
                <span class="difficulty <%= diffClass %>">
                    <%= diff %>
                </span>
                <form action="<%= request.getContextPath() %>/practice"
                      method="post" style="margin:0;">
                    <input type="hidden" name="problemId"
                           value="<%= problem.get("id") %>" />
                    <input type="hidden" name="topic"
                           value="<%= topic %>" />
                    <input type="hidden" name="action"
                           value="<%= isSolved ? "unsolve" : "solve" %>" />
                    <button type="submit"
                            style="padding:4px 12px; border-radius:6px;
                                   font-size:12px; font-weight:600;
                                   cursor:pointer; border:1px solid;
                                   font-family:'Segoe UI',sans-serif;
                                   background:<%= isSolved ? "#fff0f0" : "#f0fff4" %>;
                                   color:<%= isSolved ? "#c0392b" : "#2e7d32" %>;
                                   border-color:<%= isSolved ? "#ffd0d0" : "#b2dfdb" %>;">
                        <%= isSolved ? "Undo" : "Mark Solved" %>
                    </button>
                </form>
            </div>
        </div>
        <% } %>
    </div>

</div>

<script src="<%= request.getContextPath() %>/js/navbar.js"></script>
</body>
</html>