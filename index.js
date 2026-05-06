var featureCards = document.querySelectorAll('.feature-card');

featureCards.forEach(function(card) {
    card.addEventListener('mouseenter', function() {
        card.style.borderColor = '#3b4cca';
        card.style.transform   = 'translateY(-4px)';
    });
    card.addEventListener('mouseleave', function() {
        card.style.borderColor = '#eee';
        card.style.transform   = 'translateY(0)';
    });
});