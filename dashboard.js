/**
 * 
 */
window.addEventListener('load', function() {

    var bars = document.querySelectorAll('.bar-fill');
    bars.forEach(function(bar) {
        var width = bar.getAttribute('data-width');
        if (width) {
            bar.style.width = width + '%';
            if (width < 40) {
                bar.style.background = '#e74c3c';
            } else if (width < 70) {
                bar.style.background = '#f1c40f';
            } else {
                bar.style.background = '#2ecc71';
            }
        }
    });
});