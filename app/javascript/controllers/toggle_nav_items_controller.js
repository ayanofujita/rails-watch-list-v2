import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-nav-items"
export default class extends Controller {

  activate(event) {
    // cannot use forEach for HTML collections
    for (let child of this.element.children) {
      if (child.classList.contains('active')) child.classList.remove('active')
    }
    event.currentTarget.classList.add('active');
    console.log(event.currentTarget)
  }
}
