import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-sidebar"
export default class extends Controller {
  connect() {
  }

  toggle(){
    if (window.innerWidth <= 576){
      this.element.childNodes.forEach((element) => {
        if (element.localName == "div"){
          element.classList.toggle('d-none')
        }
      })
    }
  }
}
