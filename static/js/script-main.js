window.addEventListener("hashchange", () => window.history.pushState({}, "", '/'), {});
document.addEventListener('DOMContentLoaded', () => {
  const burger = document.getElementById('burger');
  const nav = document.querySelector('.nav');

  burger.addEventListener('click', () => {
    nav.classList.toggle('active');
  });

  if (window.location.hash === "#susisiekite") {
    document.documentElement.style.scrollBehavior = "auto";
    
    const form = document.getElementById("kontaktai");

    if(form) {
      form.scrollIntoView({behavior: "auto"});
    }
    setTimeout(() => {
      history.replaceState(null, null, window.location.pathname);
      document.documentElement.style.scrollBehavior = "smooth";
    }, 100);
  }
});