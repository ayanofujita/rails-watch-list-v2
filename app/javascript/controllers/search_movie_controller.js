import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-movie"
export default class extends Controller {
  static targets = ["input", "list"]

  search() {
    fetch('/movies/fetch_movie', {
      method: "POST",
      headers: {
        'Accept': "application/json",
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ movie_title: this.inputTarget.value})
    })
      .then(response => response.json())
      .then(data => {
        if (data.Search) {
          this.listTarget.innerHTML = ""
          data.Search.forEach ((movie) => {
            const list = `
              <li data-imdb="${movie.imdbID}" data-url="${movie.Poster}" data-controller="add-movie" data-action="click->add-movie#add">
                <button class="dropdown-item" type="button">${movie.Title} (${movie.Year})</button>
              </li>
            `
            this.listTarget.insertAdjacentHTML("beforeend", list)
          })
        } else {
          this.listTarget.innerHTML = `<li><button class="dropdown-item disabled">${data.Error}</button></li>`
        }
      })
  }
}
