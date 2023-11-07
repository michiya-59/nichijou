コードは以下のようになっています。

window.addEventListener('load', () => {
  var navIcon = document.getElementById('nav-icon');
  var mobileNav = document.getElementById('mobile-nav');

  navIcon.addEventListener('click', function() {
    this.classList.toggle('open');
    mobileNav.classList.toggle('open');
  });
  
  document.body.addEventListener('click', function(event) {
    if (!navIcon.contains(event.target) && !mobileNav.contains(event.target)) {
      navIcon.classList.remove('open');
      mobileNav.classList.remove('open');
    }
  });
});