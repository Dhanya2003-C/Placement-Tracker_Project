/**
 * 
 */
var currentPath = window.location.pathname;
var navLinks    = document.querySelectorAll('.navbar-links a');

navLinks.forEach(function(link) {
    if (currentPath.indexOf(link.getAttribute('href')) !== -1) {
        link.classList.add('active');
    }
});