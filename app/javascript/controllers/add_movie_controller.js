import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-movie"
export default class extends Controller {
  connect() {
  }

  add() {
    const movie_imdb = this.element.dataset.imdb
    const movie_poster = this.element.dataset.url
    const img = `
    <div class="me-2 mb-2">
      <img src="${movie_poster}" alt="" class="movie-poster">
      <button type="button" class="text-white" aria-label="Remove" data-controller="remove-poster" data-action="click->remove-poster#remove">
        <i class="fa-solid fa-xmark"></i>
      </button>
      <input type="hidden" name="list[movies][]" value="${movie_imdb}">
    <div>
    `
    const container = document.getElementById('selected-movies-container')
    container.insertAdjacentHTML("beforeend", img)
  }
}
