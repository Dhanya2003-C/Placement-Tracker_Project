package servlet;


import dao.QuizDAO;
import model.QuizQuestion;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/quiz")
public class QuizServlet extends HttpServlet {

    private QuizDAO quizDAO = new QuizDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        String topic = request.getParameter("topic");

        if (topic == null) {
            List<String> topics = quizDAO.getAvailableTopics();
            request.setAttribute("topics", topics);
            request.getRequestDispatcher("/jsp/quiz-topics.jsp").forward(request, response);
        } else {
            List<QuizQuestion> questions = quizDAO.getQuestionsByTopic(topic);
            session.setAttribute("quizQuestions", questions);
            session.setAttribute("quizTopic",     topic);
            session.setAttribute("quizIndex",     0);
            session.setAttribute("quizScore",     0);
            request.setAttribute("question",  questions.get(0));
            request.setAttribute("index",     1);
            request.setAttribute("total",     questions.size());
            request.setAttribute("topic",     topic);
            request.getRequestDispatcher("/jsp/quiz.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedUser") == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        List<QuizQuestion> questions =
            (List<QuizQuestion>) session.getAttribute("quizQuestions");
        int index  = (Integer) session.getAttribute("quizIndex");
        int score  = (Integer) session.getAttribute("quizScore");
        String topic = (String) session.getAttribute("quizTopic");

        String answer = request.getParameter("selectedAnswer");
        QuizQuestion current = questions.get(index);

        boolean correct = current.getCorrectOption().equalsIgnoreCase(answer);
        if (correct) score++;

        index++;

        session.setAttribute("quizIndex", index);
        session.setAttribute("quizScore", score);

        if (index >= questions.size()) {
            quizDAO.saveResult(userId, topic, score, questions.size());
            session.removeAttribute("quizQuestions");
            session.removeAttribute("quizIndex");
            request.setAttribute("score",       score);
            request.setAttribute("total",       questions.size());
            request.setAttribute("topic",       topic);
            request.setAttribute("lastCorrect", current.getCorrectOption());
            request.setAttribute("explanation", current.getExplanation());
            request.getRequestDispatcher("/jsp/quiz-result.jsp").forward(request, response);
        } else {
            request.setAttribute("question",     questions.get(index));
            request.setAttribute("index",        index + 1);
            request.setAttribute("total",        questions.size());
            request.setAttribute("topic",        topic);
            request.setAttribute("lastCorrect",  current.getCorrectOption());
            request.setAttribute("wasCorrect",   correct);
            request.setAttribute("explanation",  current.getExplanation());
            request.getRequestDispatcher("/jsp/quiz.jsp").forward(request, response);
        }
    }
}