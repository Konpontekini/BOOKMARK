// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)

// const sortItemButton = document.getElementById("sort-button")
// console.log(sortItemButton);
// sortItemButton.addEventListener("click", (e) => {
//   console.log("buttonclick");
//   sortItems()
// })

// function sortItems() {
//   Item.all = Item.all.sort((a, b) => {
//     console.log(a);
//     console.log(b);
//     let nameA = a.item_name;
//     let nameB = b.item_name;
//       if(nameA < nameB) {
//         return -1;
//       }
//       if (nameA > nameB){
//         return 1;
//       }
//       return 0;
//   })
// }
