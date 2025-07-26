import { Controller } from "@hotwired/stimulus"

export default class ModalController extends Controller {
  connect() {
    this.element.addEventListener("click", (e) => {
      if (e.target === this.element) {
        this.close()
      }
    })

    document.addEventListener("keydown", this._handleKeydown.bind(this))
  }

  disconnect() {
    document.removeEventListener("keydown", this._handleKeydown.bind(this))
  }

  close() {
    this.element.remove()

    const modal = document.querySelector("turbo-frame#modal")
    modal.removeAttribute("src")
  }

  _handleKeydown(event) {
    if (event.key === "Escape") {
      this.close()
    }
  }
}
