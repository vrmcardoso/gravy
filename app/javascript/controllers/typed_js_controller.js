import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {

  static targets = ["input"]

  connect() {
    new Typed(this.inputTarget, {
      strings: ["Find a dish", "Find a restaurant", "Find yourself"],
      attr: 'placeholder',
      bindInputFocusEvents: true,
      typeSpeed: 50,
      loop: true
    })
  }
}
