// card footer section
// export function showHover() {
//   const itemCard = document.querySelectorAll(".item-card")
//   itemCard.forEach(card => {
//     // console.dir(card)
//     const detailShow = card.childNodes[9]
//     card.addEventListener('mouseover', ()=> {
//       detailShow.style.display = "block"
//     })
//     card.addEventListener('mouseleave', () => {
//       detailShow.style.display = "none"
//     })
//   })
// }

// quick view section
export function showHover() {
  const itemCard = document.querySelectorAll(".item-card")
  itemCard.forEach(card => {
    // console.dir(card)
    const detailShow = card.childNodes[1].childNodes[3]
    card.addEventListener('mouseover', ()=> {
      detailShow.style.display = "block"
    })
    card.addEventListener('mouseleave', () => {
      detailShow.style.display = "none"
    })
  })
}
