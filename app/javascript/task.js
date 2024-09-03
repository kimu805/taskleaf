const destroy = () => {
  document.querySelectorAll(".delete").forEach(function(a) {
    a.addEventListener("click", function() {
      var frameTag = a.parentNode
      var td = frameTag.parentNode
      var tr = td.parentNode
      tr.style.display = "none"
    })
  })
}

window.addEventListener("turbo:load", destroy)