// Members page filtering functionality

document.addEventListener('DOMContentLoaded', function() {
  const filterButtons = document.querySelectorAll('.filter-btn');
  const memberCards = document.querySelectorAll('.member-card-full');

  filterButtons.forEach(button => {
    button.addEventListener('click', function() {
      const filterValue = this.getAttribute('data-filter');

      // Update active button
      filterButtons.forEach(btn => btn.classList.remove('active'));
      this.classList.add('active');

      // Filter cards
      memberCards.forEach(card => {
        const cardCategory = card.getAttribute('data-category');

        // Filter cards – make comparison case‑insensitive and allow partial matches
        const filter = filterValue.toLowerCase();
        const cardCat = (cardCategory || '').toLowerCase();
        if (filter === 'all' || cardCat.includes(filter)) {
          card.classList.remove('hide');
          setTimeout(() => {
            card.style.display = 'flex';
          }, 10);
        } else {
          card.classList.add('hide');
          card.style.display = 'none';
        }
      });
    });
  });

  // Smooth scroll animation for reveal elements
  const reveals = document.querySelectorAll('.reveal');
  
  reveals.forEach(element => {
    element.style.opacity = '0';
    element.style.transform = 'translateY(20px)';
    element.style.transition = 'opacity 0.6s ease, transform 0.6s ease';
  });

  const revealOnScroll = () => {
    reveals.forEach(element => {
      const windowHeight = window.innerHeight;
      const revealTop = element.getBoundingClientRect().top;
      const revealPoint = 100;

      if (revealTop < windowHeight - revealPoint) {
        element.style.opacity = '1';
        element.style.transform = 'translateY(0)';
      }
    });
  };

  window.addEventListener('scroll', revealOnScroll);
  revealOnScroll(); // Check on load
});
