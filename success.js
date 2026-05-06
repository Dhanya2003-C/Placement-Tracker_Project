/**
 * 
 */
var countdownEl = document.getElementById('countdown');
var seconds     = 5;

var timer = setInterval(function() {
    seconds--;
    if (countdownEl) {
        countdownEl.textContent = seconds;
    }
    if (seconds <= 0) {
        clearInterval(timer);
        window.location.href = 'login.jsp';
    }
}, 1000);