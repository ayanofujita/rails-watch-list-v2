import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="remove-poster"
export default class extends Controller {
  remove() {
    this.element.parentElement.remove()
  }
}
