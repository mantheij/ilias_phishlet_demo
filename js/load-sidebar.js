// Load central sidebar on all pages
document.addEventListener('DOMContentLoaded', function() {
  fetch('/sidebar.html')
    .then(response => response.text())
    .then(html => {
      // Remove any existing sidebars
      const existingSidebar = document.querySelector('.sidebar');
      const existingHamburger = document.querySelector('.hamburger');
      if (existingSidebar) existingSidebar.remove();
      if (existingHamburger) existingHamburger.remove();
      
      // Insert the central sidebar at the beginning of body
      document.body.insertAdjacentHTML('afterbegin', html);
      
      // Reattach hamburger menu functionality
      const hamburger = document.querySelector('.hamburger');
      const sidebar = document.querySelector('.sidebar');
      
      if (hamburger && sidebar) {
        // Highlight active page
        const currentPage = window.location.pathname.split('/').pop().replace('.html', '') || 'index';
        const activeLink = sidebar.querySelector('.nav-link[data-page="' + currentPage + '"]');
        if (activeLink) {
          activeLink.classList.add('active');
        }
        
        hamburger.addEventListener('click', function() {
          hamburger.classList.toggle('open');
          sidebar.classList.toggle('open');
          if (sidebar.classList.contains('open')) {
            hamburger.style.left = '200px';
          } else {
            hamburger.style.left = '20px';
          }
        });
        
        // Close sidebar when clicking outside
        document.addEventListener('click', function(event) {
          if (!event.target.closest('.sidebar') && !event.target.closest('.hamburger')) {
            hamburger.classList.remove('open');
            sidebar.classList.remove('open');
          }
        });
        
        // Close sidebar when clicking on a link
        sidebar.querySelectorAll('.nav-link').forEach(link => {
          link.addEventListener('click', function() {
            sidebar.classList.remove('open');
          });
        });
      }
    })
    .catch(err => console.error('Error loading sidebar:', err));
});
