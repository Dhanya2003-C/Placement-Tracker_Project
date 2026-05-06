var passwordInput = document.getElementById('passwordInput');
var strengthFill  = document.getElementById('strengthFill');
var strengthText  = document.getElementById('strengthText');
var togglePwd     = document.getElementById('togglePwd');
var registerForm  = document.getElementById('registerForm');

var levels = [
    { label: 'Too short', color: '#e74c3c' },
    { label: 'Weak',      color: '#e67e22' },
    { label: 'Fair',      color: '#f1c40f' },
    { label: 'Good',      color: '#2ecc71' },
    { label: 'Strong',    color: '#27ae60' }
];

if (passwordInput) {
    passwordInput.addEventListener('input', function() {
        var val   = passwordInput.value;
        var score = 0;

        if (val.length >= 6)           score++;
        if (val.length >= 10)          score++;
        if (/[A-Z]/.test(val))         score++;
        if (/[0-9]/.test(val))         score++;
        if (/[^A-Za-z0-9]/.test(val))  score++;

        var i = Math.min(score, 4);

        if (val.length === 0) {
            strengthFill.style.width       = '0%';
            strengthText.textContent       = '';
        } else {
            strengthFill.style.width      = ((score / 5) * 100) + '%';
            strengthFill.style.background = levels[i].color;
            strengthText.textContent      = levels[i].label;
            strengthText.style.color      = levels[i].color;
        }
    });
}

if (togglePwd) {
    togglePwd.addEventListener('click', function() {
        if (passwordInput.type === 'password') {
            passwordInput.type    = 'text';
            togglePwd.textContent = 'Hide';
        } else {
            passwordInput.type    = 'password';
            togglePwd.textContent = 'Show';
        }
    });
}

if (registerForm) {
    registerForm.addEventListener('submit', function(e) {
        var name  = document.getElementById('fullName').value.trim();
        var email = document.getElementById('email').value.trim();
        var pwd   = passwordInput.value.trim();
        var type  = document.querySelector('input[name="userType"]:checked');
        var valid = true;

        document.getElementById('nameError').textContent  = '';
        document.getElementById('emailError').textContent = '';
        document.getElementById('typeError').textContent  = '';

        if (name.length < 3) {
            document.getElementById('nameError').textContent = 'Name must be at least 3 characters.';
            valid = false;
        }

        if (!email.includes('@') || !email.includes('.')) {
            document.getElementById('emailError').textContent = 'Enter a valid email address.';
            valid = false;
        }

        if (pwd.length < 6) {
            strengthText.textContent   = 'Password must be at least 6 characters.';
            strengthText.style.color   = '#e74c3c';
            valid = false;
        }

        if (!type) {
            document.getElementById('typeError').textContent = 'Please select who you are.';
            valid = false;
        }

        if (!valid) {
            e.preventDefault();
        }
    });
}