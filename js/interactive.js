$(document).ready(function() {
  // Aktive Seite hervorheben basierend auf URL
  var currentPage = window.location.pathname.split('/').pop().replace('.html', '') || 'index';
  $('.nav-link[data-page="' + currentPage + '"]').addClass('active');

  $('.hamburger').on('click', function() {
    $(this).toggleClass('open');
    $('.sidebar').toggleClass('open');
    if ($('.sidebar').hasClass('open')) {
      $(this).css('left', '200px');
    } else {
      $(this).css('left', '20px');
    }
  });

  // Sidebar schließen, wenn außerhalb geklickt wird, und Hamburger zurücksetzen
  $(document).on('click', function(event) {
    if (!$(event.target).closest('.sidebar, .hamburger').length) {
      $('.hamburger').removeClass('open');
      $('.sidebar').removeClass('open');
    }
  });

  // Hover-Effekte entfernt, um unbeabsichtigtes Öffnen zu vermeiden
  // $('.sidebar-trigger').hover(
  //   function() {
  //     $('.sidebar').addClass('open');
  //   },
  //   function() {
  //   }
  // );
});