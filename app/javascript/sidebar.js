const lists = document.querySelectorAll(".sidebar a");

const addClass = lists.forEach((list) => {
  list.addEventListener("click", (event) => {
    list.classList.add("active");
    });
  });

export { addClass };
