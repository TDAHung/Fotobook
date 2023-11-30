const fileInput = document.getElementById('file-upload');
const fileLabel = document.querySelector('.file-label');
const imagePreview = document.getElementById('image-preview');
const buttonGroup = document.querySelector('.button-group');
const imgGroup = document.querySelector('.imgGroup');
let dataGlobal = new DataTransfer();
const middleImgGroup = imgGroup.innerHTML;

const fetchPromises = [];
const albumDataTransfer = new DataTransfer();
const previewImg = document.querySelectorAll('.photoUrl');
const handleAddImg = (src, index) => {
    const imgPreview = document.cloneNode(true).querySelector('.preview');
    const img = imgPreview.querySelector("img");
    img.src = src;
    const deleteButtonNode = document.querySelector("#deleteButton");
    const deleteButtonFragment = deleteButtonNode.content.cloneNode(true);
    const deleteButtonElement = deleteButtonFragment.querySelector("div");
    imgPreview.setAttribute("id", `img${src.split("/").pop()}`);
    deleteButtonElement.setAttribute("id", imgPreview.id);
    deleteButtonElement.addEventListener('click', () => {
        removeImg(imgPreview.id, index);
    });
    imgPreview.appendChild(deleteButtonElement);
    const deleteReal = imgPreview.querySelector(`#${imgPreview.id}`);
    imgPreview.innerHTML = '';
    imgPreview.appendChild(deleteReal);
    imgPreview.appendChild(img);
    return imgPreview;
}

const removeImg = (imgID, index) => {
    const imgPreview = document.querySelector(`#${imgID}`);
    imgGroup.removeChild(imgPreview);
    for (let i = 0; i < fileInput.files.length; i++) {
        const file = fileInput.files[i]
        if (index !== i)
            dataGlobal.items.remove(file)
    }
    fileInput.files = dataGlobal.files;
}

const uploadFiles = files => {
    for (let i = 0; i < files.length; i++) {
        const file = files[i];
        dataGlobal.items.add(file);
    }
    fileInput.files = dataGlobal.files;
    if (fileInput.files.length > 0) {
        const srcs = Array.from(fileInput.files).map(file => URL.createObjectURL(file));
        imgGroup.innerHTML = middleImgGroup;
        srcs.forEach((element, index) => {
            imgGroup.insertBefore(handleAddImg(element, index), document.querySelector('.preview'));
        });
    } else {
        imagePreview.src = '#';
        fileLabel.textContent = 'No file selected';
    }
}

fileInput.addEventListener('change', () => {
    uploadFiles(fileInput.files);
});

window.addEventListener('DOMContentLoaded', () => {
    const initialFiles = [];
    previewImg.forEach(img => {
        initialFiles.push({ url: img.value, name: img.name })
    });
    const filesToUpload = initialFiles.map(img => fetch(img.url).then(response => response.blob()));

    Promise.all(filesToUpload)
        .then(blobs => {
            const fileObjects = blobs.map((blob, index) => new File([blob], `${initialFiles[index].name}`));
            uploadFiles(fileObjects);
        })
        .catch(error => {
            console.error('Failed to fetch or process initial files:', error);
        });
});

