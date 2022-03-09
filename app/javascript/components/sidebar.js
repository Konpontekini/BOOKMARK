export function addClass() {
  const lists = document.querySelectorAll(".sidebar a");
  lists.forEach((list) => {
  list.addEventListener("click", (event) => {
    list.classList.add("active");
    });
  });
};

// export { addClass };
