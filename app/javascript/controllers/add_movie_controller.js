import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="add-movie"
export default class extends Controller {
  connect() {
  }

  add() {
    console.log("clicked!")
    const movie_imdb = this.element.dataset.imdb
    const movie_poster = this.element.dataset.url
    const img = `<img src="${movie_poster}" alt="" class="movie-poster me-2 mb-2" data-imdb="${movie_imdb}">`
    const container = document.getElementById('selected-movies-container')
    container.insertAdjacentHTML("beforeend", img)
  }
}
