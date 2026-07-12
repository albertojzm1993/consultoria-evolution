/* Interacciones base — sin dependencias. Adáptalo a cada proyecto. */
(function () {
  "use strict";

  // --- Navegación móvil ---
  var nav = document.querySelector(".nav");
  var toggle = document.querySelector(".nav__toggle");
  if (nav && toggle) {
    toggle.addEventListener("click", function () {
      var open = nav.getAttribute("data-open") === "true";
      nav.setAttribute("data-open", String(!open));
      toggle.setAttribute("aria-expanded", String(!open));
    });
  }

  // --- Acordeón FAQ ---
  document.querySelectorAll(".faq__q").forEach(function (q) {
    q.addEventListener("click", function () {
      var item = q.closest(".faq__item");
      var open = item.getAttribute("aria-expanded") === "true";
      item.setAttribute("aria-expanded", String(!open));
      q.setAttribute("aria-expanded", String(!open));
    });
  });

  // --- Revelado al hacer scroll ---
  var reduce = window.matchMedia("(prefers-reduced-motion: reduce)").matches;
  var reveals = document.querySelectorAll(".reveal");
  if (!reduce && "IntersectionObserver" in window && reveals.length) {
    var io = new IntersectionObserver(function (entries) {
      entries.forEach(function (e) {
        if (e.isIntersecting) { e.target.classList.add("in"); io.unobserve(e.target); }
      });
    }, { threshold: 0.15 });
    reveals.forEach(function (el) { io.observe(el); });
  } else {
    reveals.forEach(function (el) { el.classList.add("in"); });
  }

  // --- Validación de formularios (cliente) ---
  document.querySelectorAll("form[data-validate]").forEach(function (form) {
    form.addEventListener("submit", function (e) {
      var ok = true;
      form.querySelectorAll("[required]").forEach(function (input) {
        var field = input.closest(".field");
        var valid = input.value.trim() !== "" &&
          (input.type !== "email" || /.+@.+\..+/.test(input.value));
        field && field.classList.toggle("field--error", !valid);
        if (!valid) ok = false;
      });
      if (!ok) { e.preventDefault(); }
    });
  });
})();
