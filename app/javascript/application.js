// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

window.addEventListener("resize", hideSidebar);
function hideSidebar() {
  if (window.innerWidth <= 576){
    document.querySelector('.sidebar').childNodes.forEach((element) => {
      if (element.localName == "div"){
        element.classList.add('d-none')
      }
    })
  } else {
    document.querySelector('.sidebar').childNodes.forEach((element) => {
      if (element.localName == "div"){
        element.classList.remove('d-none')
      }
    })
  }
}
