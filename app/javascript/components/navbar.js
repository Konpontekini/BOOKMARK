const toogleDropdown = () => {
  const dropdown = document.getElementById("dropdown-menu");

  if (dropdown.classList.contains('open')) {
    dropdown.classList.remove('open')
  } else {
    dropdown.classList.add('open')
  }
}

export function initialiseDropdown() {
  // document.getElementById("navbarDropdown").addEventListener("click", toogleDropdown)
  document.addEventListener('click', (e) => {
    console.log(e)
    if (e.target.className.includes("avatar dropdown-toggle")) {
      toogleDropdown()
    }
    else {
      const dropdown = document.getElementById("dropdown-menu")
      dropdown.classList.remove('open') }
  })
}
