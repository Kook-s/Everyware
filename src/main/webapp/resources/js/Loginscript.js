const wrapper = document.querySelector(".wrapper");
const loginLink = document.querySelector(".login-link");
const registerLink = document.querySelector(".register-link");

const findlink = document.querySelector(".find-link");
const sreachlink = document.querySelector(".sreach-link");

const btnPopup = document.querySelector(".btnLogin-popup");
const iconClose = document.querySelector(".icon-close");


findlink.addEventListener("click", () => {
  wrapper.classList.add("active2");
});

sreachlink.addEventListener("click", () => {
  wrapper.classList.remove("active2");
});
/*
registerLink.addEventListener("click", () => {
  wrapper.classList.add("active");
});

loginLink.addEventListener("click", () => {
  wrapper.classList.remove("active");
});
*/

