const destroy = () => {
  document.querySelectorAll(".delete").forEach(function(a) {
    a.addEventListener("click", function() {
      var td = a.parentNode
      var tr = td.parentNode
      tr.style.display = "none"
    })
  })
}

window.addEventListener("turbo:load", destroy)