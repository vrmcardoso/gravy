import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="change-class"
export default class extends Controller {

  connect() {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    let selected = urlParams.get("query")
    document.getElementById(selected).classList.add("icon-card-active")
  }
}
