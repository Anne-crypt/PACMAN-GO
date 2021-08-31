const chooseColor = () => {

  const ghostChosen = document.querySelector(".ghost_chosen")

  if (ghostChosen) {

    const ghosts = document.querySelectorAll(".ghost")

    ghosts.forEach((ghost) => {
      ghost.addEventListener("click", (event) => {
        const url = event.currentTarget.src
        ghostChosen.src = url
      })
    })
  }

}

export {chooseColor}
