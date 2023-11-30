const fileInput = document.getElementById('file-upload');
const fileLabel = document.querySelector('.file-label');
const imagePreview = document.getElementById('image-preview');
const buttonGroup = document.querySelector('.button-group');
const deleteButtonNode = document.querySelector('#btn-remove');
const dataGlobal = new DataTransfer();
const imgGroup = document.querySelector('.imgGroup');
const middleImgGroup = imgGroup.innerHTML;
const previewImg = document.querySelector('.photoUrl');

const uploadFiles = files => {
    dataGlobal.clearData();
    dataGlobal.items.add(files[0]);
    fileInput.files = dataGlobal.files;
    console.log(fileInput.files);
    if (fileInput.files.length > 0) {
        const reader = new FileReader();
        reader.onload = () => {
            imagePreview.src = reader.result;
        };
        reader.readAsDataURL(fileInput.files[0]);
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
    initialFiles.push({ url: previewImg.value, name: previewImg.name })
    const filesToUpload = initialFiles.map(img => fetch(img.url).then(response => response.blob()));
    Promise.all(filesToUpload)
        .then(blobs => {
            const fileObjects = blobs.map((blob, index) => new File([blob], `${initialFiles[index].name}`))
            uploadFiles(fileObjects);
        })
        .catch(error => {
            console.error('Failed to fetch or process initial files:', error);
        });
});

deleteButtonNode.addEventListener('click', (event) => {
    event.preventDefault();
    imagePreview.src = '/assets/avatar.png';
    const data = new DataTransfer();
    fileInput.files = data.files;
});
