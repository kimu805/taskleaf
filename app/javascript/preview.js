function preview() {
  const previews = document.getElementById("previews")
  const taskImage = document.querySelector('input[type="file"][name="task[images][]"]')

  if (!previews) return null

  const buildPreviewImage = (dataIndex, blob) => {
    const preview = document.createElement("div")
    preview.setAttribute("class", "preview mt-3 me-3")
    preview.setAttribute("data-index", dataIndex)

    const previewImage = document.createElement("img")
    previewImage.setAttribute("class", "preview-image")
    previewImage.setAttribute("src", blob)
    previewImage.setAttribute("alt", "画像プレビュー")
    previewImage.setAttribute("width", "300")
    previewImage.setAttribute("height", "200")

    preview.appendChild(previewImage)
    previews.appendChild(preview)
  }

  const buildNewFileField = () => {
    const newFileField = document.createElement("input")
    newFileField.setAttribute("type", "file")
    newFileField.setAttribute("name", "task[images][]")
    newFileField.setAttribute("class", "form-control mt-3")

    const lastFileField = document.querySelector('input[type="file"][name="task[images][]"]:last-of-type');
    const nextDataIndex = Number(lastFileField.getAttribute('data-index')) +1;
    newFileField.setAttribute('data-index', nextDataIndex);

    newFileField.addEventListener("change", changeFileField)

    const fileFieldArea = document.querySelector(".images")
    fileFieldArea.appendChild(newFileField)
  }

  const changeFileField = (e) => {
    const dataIndex = e.target.getAttribute('data-index');

    const file = e.target.files[0]
    const blob = window.URL.createObjectURL(file)

    const alreadyPreview = document.querySelector(`.preview[data-index="${dataIndex}"]`)
    if (alreadyPreview) {
      const alreadyPreviewImage = alreadyPreview.querySelector("img")
      alreadyPreviewImage.setAttribute("src", blob)
      return null
    }

    buildPreviewImage(dataIndex, blob)
    buildNewFileField()
  }

  

  taskImage.addEventListener("change", changeFileField)
}

window.addEventListener("turbo:load", preview)