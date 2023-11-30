document.addEventListener("DOMContentLoaded", () => {

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
            const photo = document.querySelector(`#${element.getAttribute("id")}`);
            const modal = document.querySelector('#photoModal');
            modal.querySelector(".modal-title").innerText = photo.querySelector(".user__image__title").innerText;
            modal.querySelector(".modal-description").innerText = photo.querySelector(".user__image__description").innerText;
            const imgElement = photo.querySelectorAll(".user__image img");
            const carouselInner = modal.querySelector(".carousel-inner");
            carouselInner.innerHTML = '';
            imgElement.forEach(img => {
                carouselInner.appendChild(handleShowModal(img));
            });
            carouselInner.querySelector(".carousel-item").classList.add("active");
            try {
                const editBtn = modal.querySelector(".btn-success");
                const deleteBtn = modal.querySelector(".btn-danger");
                const type = document.querySelector("#type");
                editBtn.href = `/${type.value}/${element.getAttribute("id").substring(6)}/edit`;
                deleteBtn.href = `/${type.value}/${element.getAttribute("id").substring(6)}`;
            } catch (error) {
                console.log(error);
            }
        });
    });

    const navbarResponsive = document.querySelector(".navbar-responsive");
    const navbarNormal = document.querySelector(".navbar-normal");
    navbarResponsive.addEventListener("click", () => {
        navbarNormal.classList.add("active");
        navbarResponsive.classList.add("d-none");
    });
});


