import { Controller } from "@hotwired/stimulus"

export default class ModalController extends Controller {
  close() {
    this.element.remove()

    const modalFrame = document.querySelector("turbo-frame#modal")

    if (modalFrame) {
      modalFrame.removeAttribute("src")
    }
  }
}
