<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="model.QuizQuestion" %>
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
    QuizQuestion question = (QuizQuestion) request.getAttribute("question");
    int index  = (Integer) request.getAttribute("index");
    int total  = (Integer) request.getAttribute("total");
    String topic = (String) request.getAttribute("topic");

    Boolean wasCorrect   = (Boolean) request.getAttribute("wasCorrect");
    String lastCorrect   = (String)  request.getAttribute("lastCorrect");
    String explanation   = (String)  request.getAttribute("explanation");
%>

<div class="quiz-wrapper">

    <% if (wasCorrect != null) { %>
        <div style="padding:12px 16px; border-radius:10px; margin-bottom:16px;
                    font-size:13px; font-weight:500;
                    background:<%= wasCorrect ? "#f0fff4" : "#fff0f0" %>;
                    color:<%= wasCorrect ? "#2e7d32" : "#c0392b" %>;">
            <%= wasCorrect ? "Correct!" : "Wrong! Correct answer: " + lastCorrect %>
            — <%= explanation %>
        </div>
    <% } %>

    <div class="quiz-card">
        <div class="quiz-top">
            <div class="quiz-progress-text">
                Question <%= index %> of <%= total %> — <%= topic %>
            </div>
            <div class="quiz-timer" id="quizTimer">00:30</div>
        </div>

        <div class="progress-bar">
            <div class="progress-fill"
                 style="width:<%= (index * 100) / total %>%"></div>
        </div>

        <div class="question-text"><%= question.getQuestion() %></div>

        <form action="<%= request.getContextPath() %>/quiz" method="post"
              id="quizForm">
            <input type="hidden" name="selectedAnswer"
                   id="selectedAnswer" value="" />

            <div class="options-grid">
                <button type="button" class="option-btn"
                        data-value="A"
                        onclick="selectOption(this)">
                    A. <%= question.getOptionA() %>
                </button>
                <button type="button" class="option-btn"
                        data-value="B"
                        onclick="selectOption(this)">
                    B. <%= question.getOptionB() %>
                </button>
                <button type="button" class="option-btn"
                        data-value="C"
                        onclick="selectOption(this)">
                    C. <%= question.getOptionC() %>
                </button>
                <button type="button" class="option-btn"
                        data-value="D"
                        onclick="selectOption(this)">
                    D. <%= question.getOptionD() %>
                </button>
            </div>

            <div class="quiz-nav">
                <button type="submit" class="btn-primary"
                        id="nextBtn" disabled>
                    <%= index == total ? "Finish" : "Next" %>
                </button>
            </div>
        </form>
    </div>
</div>

<script src="<%= request.getContextPath() %>/js/quiz.js"></script>
<script>
function selectOption(btn) {
    document.querySelectorAll('.option-btn').forEach(function(b) {
        b.classList.remove('selected');
    });
    btn.classList.add('selected');
    document.getElementById('selectedAnswer').value = btn.getAttribute('data-value');
    document.getElementById('nextBtn').disabled = false;
}
</script>
</body>
</html>