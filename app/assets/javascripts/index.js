document.addEventListener("DOMContentLoaded", () => {
    const albumNode = document.querySelectorAll(".child-node");
    albumNode.forEach(element => {
        const descriptionNode = element.querySelector(".photo__description");

        let string = descriptionNode.innerText;
        if (string.length > 150) {
            string = string.substring(0, 150) + '...';
        }
        descriptionNode.innerText = string;
    });

    const handleShowModal = carouselImgObject => {
        const carouselImgTemplate = document.querySelector("#template__carousel__img");
        const carouselImgFragment = carouselImgTemplate.content.cloneNode(true);
        const carouselImgElement = carouselImgFragment.querySelector("div");
        const img = carouselImgElement.querySelector("img");
        img.src = carouselImgObject.src;
        return carouselImgElement;
    }

    const buttonModal = document.querySelectorAll(".photo__wrapper");
    buttonModal.forEach(element => {
        element.addEventListener("click", () => {
            const album = document.querySelector(`#album_${element.getAttribute("id").substring(6)}`);
            const modal = document.querySelector('#photoModal');
            modal.querySelector(".modal-title").innerText = album.querySelector(".photo__title").innerText;
            modal.querySelector(".modal-description").innerText = album.querySelector(".photo__description").innerText;
            const imgElement = album.querySelectorAll(".photo img");
            const carouselInner = modal.querySelector(".carousel-inner");
            carouselInner.innerHTML = '';
            imgElement.forEach(img => {
                carouselInner.appendChild(handleShowModal(img));
            });
            carouselInner.querySelector(".carousel-item").classList.add("active");
        });
    });
    const navbarResponsive = document.querySelector(".navbar-responsive");
    const navbarNormal = document.querySelector(".navbar-normal");
    navbarResponsive.addEventListener("click", () => {
        navbarNormal.classList.add("active");
        navbarResponsive.classList.add("d-none");
    });
});


