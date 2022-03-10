export const deleteHover = () => {
  const itemCard = document.querySelectorAll(".item-card")
  itemCard.forEach(card => {
    // console.dir(card)
    const deleteIcon = card.childNodes[3].childNodes[7]
    card.addEventListener('mouseover', ()=> {
      deleteIcon.style.display = "block"
    })
    card.addEventListener('mouseleave', () => {
      deleteIcon.style.display = "none"
    })
  })
}
