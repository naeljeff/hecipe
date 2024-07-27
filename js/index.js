const hamburger = document.getElementById("hamburger-icon");
const navAuth = document.getElementsByClassName("nav-auth")[0];

hamburger.addEventListener("click", () => {
  if (navAuth.className.includes("active")) {
    navAuth.classList.remove("active");
  } else {
    navAuth.classList.add("active");
  }
});
