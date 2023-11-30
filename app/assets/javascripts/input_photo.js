const fileInput = document.getElementById('file-upload');
const fileLabel = document.querySelector('.file-label');
const imagePreview = document.getElementById('image-preview');
const buttonGroup = document.querySelector('.button-group');
const deleteButtonNode = document.querySelector('#btn-remove');

fileInput.addEventListener('change', () => {
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
});

deleteButtonNode.addEventListener('click', (event) => {
    event.preventDefault();
    imagePreview.src = '/assets/camera.png';
    const data = new DataTransfer();
    fileInput.files = data.files;
});
