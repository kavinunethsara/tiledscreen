const setupGallery = () => {
    const gallery = document.querySelector("#gallery")
    if (!gallery) return
    const thumbnails = gallery.querySelectorAll(".thumbnail")
    thumbnails.forEach(thumbnail => {
        thumbnail.addEventListener('click',
                     () => changeActive( gallery, thumbnail )
        )
    })
}

const changeActive = (gallery, thumbnail) => {
    const image = gallery.querySelector(".active")
    const source = thumbnail.src
    gallery.querySelector(".current")?.classList.remove("current")
    thumbnail.classList.add("current")
    image.src = source
}

setupGallery()
