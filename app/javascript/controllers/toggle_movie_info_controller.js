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

    fetch('/movies/fetch_movie_info', {
      method: "POST",
      headers: {
        'Accept': "text/plain",
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content')
      },
      body: JSON.stringify({ movie_id: e.currentTarget.id })
    })
      .then(response => response.text())
      .then(data => {
        const currentDiv = document.querySelector('.movie-info')

        if (currentDiv && lastImage.nextSibling == currentDiv) {
          currentDiv.outerHTML = data
        }
        else {
          if (currentDiv) currentDiv.remove()
          lastImage.insertAdjacentHTML('afterend', data)
        }
      })
  }
}
