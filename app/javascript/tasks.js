document.addEventListener("turbo:load", function() {
  document.querySelectorAll(".delete").forEach(function(a) {
    console.log("読み込み完了")
    a.addEventListener("ajax:success", function() {
      var td = a.parentNode
      var tr = td.parentNode
      tr.style.display = "none"
    })
  })


  document.querySelectorAll("td").forEach(function(td) {
    td.addEventListener("mouseover", function(e) {
      e.currentTarget.style.backgroundColor = "#eff"
    })

    td.addEventListener("mouseout", function(e) {
      e.currentTarget.style.backgroundColor = ""
    })
  })
})

