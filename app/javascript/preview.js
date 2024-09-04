function preview() {
  const previews = document.getElementById("previews")
  const taskImage = document.getElementById("task_image")

  if (!previews) return null

  taskImage.addEventListener("change", (e) => {

    const alreadyPreview = document.querySelector(".preview")
    if (alreadyPreview) alreadyPreview.remove()

    const file = e.target.files[0]
    const blob = URL.createObjectURL(file)

    const preview = document.createElement("div")
    preview.setAttribute("class", "preview mt-3")

    const previewImage = document.createElement("img")
    previewImage.setAttribute("src", blob)
    previewImage.setAttribute("alt", "画像プレビュー")
    previewImage.setAttribute("width", "300")
    previewImage.setAttribute("height", "200")

    preview.appendChild(previewImage)
    previews.appendChild(preview)
  })
}

window.addEventListener("turbo:load", preview)