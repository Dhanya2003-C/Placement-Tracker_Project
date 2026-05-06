/**
 * 
 */
var timeLeft    = 30;
var timerEl     = document.getElementById('quizTimer');
var timerInterval;
var selected    = null;
var answered    = false;

function startTimer() {
    timerInterval = setInterval(function() {
        timeLeft--;
        if (timerEl) {
            timerEl.textContent = '00:' + (timeLeft < 10 ? '0' : '') + timeLeft;
        }
        if (timeLeft <= 10 && timerEl) {
            timerEl.classList.add('warning');
        }
        if (timeLeft <= 0) {
            clearInterval(timerInterval);
            autoSubmit();
        }
    }, 1000);
}

function autoSubmit() {
    var form = document.getElementById('quizForm');
    if (form) {
        form.submit();
    }
}

var options = document.querySelectorAll('.option-btn');
options.forEach(function(btn) {
    btn.addEventListener('click', function() {
        if (answered) return;

        options.forEach(function(b) {
            b.classList.remove('selected');
        });

        btn.classList.add('selected');
        selected = btn.getAttribute('data-value');

        var hiddenInput = document.getElementById('selectedAnswer');
        if (hiddenInput) {
            hiddenInput.value = selected;
        }
    });
});

if (timerEl) {
    startTimer();
}