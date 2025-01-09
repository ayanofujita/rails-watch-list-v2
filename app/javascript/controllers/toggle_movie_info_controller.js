import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="show-movie-info"
export default class extends Controller {
  connect() {
  }

  show(e) {
    const rowTop = e.currentTarget.offsetTop
    let lastImage = this.currentTarget

    const images = [...this.element.children]
    images.forEach(image => {
      if (image.offsetTop === rowTop) {
        lastImage = image
      }
    });
    let currentDiv = document.querySelector('.movie-info')
    // console.log(e.currentTarget.dataset.movieId)
    // console.log(currentDiv.dataset.movieId)
    if (currentDiv && e.currentTarget.dataset.movieId == currentDiv.dataset.movieId) {
      currentDiv.outerHTML = "";
    } else {
      fetch('/movies/fetch_movie_info', {
        method: "POST",
        headers: {
          'Accept': "text/plain",
          'Content-Type': 'application/json',
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        },
        body: JSON.stringify({ movie_id: e.currentTarget.dataset.movieId })
      })
        .then(response => response.text())
        .then(data => {
          if (currentDiv && lastImage.nextSibling == currentDiv) {
            currentDiv.outerHTML = data
          }
          else {
            if (currentDiv) currentDiv.remove()
            lastImage.insertAdjacentHTML('afterend', data)
            document.querySelector('.movie-info').scrollIntoView({ behavior: 'smooth', block: 'center' });
          }
        })
    }
  }
}
