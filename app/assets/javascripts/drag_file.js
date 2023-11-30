const fileAvatarInput = document.getElementById('avatar');
const fileAvatarLabel = document.querySelector('.file-label');
const imageAvatarPreview = document.querySelector('.form__img img');

fileAvatarInput.addEventListener('change', () => {
    if (fileAvatarInput.files.length > 0) {
        const reader = new FileReader();
        reader.onload = () => {
            imageAvatarPreview.src = reader.result;
        };
        reader.readAsDataURL(fileAvatarInput.files[0]);

    } else {
        imageAvatarPreview.src = '#';
        fileAvatarLabel.textContent = 'No file selected';
    }
});
