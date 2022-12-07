import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"
import Rails from "@rails/ujs";

export default class extends Controller {

  connect() {

    this.sortable = Sortable.create(this.element, {
      onEnd: this.end.bind(this)
    })
  }

  end(event) {
    // console.log(event)
    // console.log(event.newDraggableIndex)
    // console.log(event.oldDraggableIndex)
    const allCards = document.querySelectorAll(".rank-box-2");
    const images = [`<img src="https://res.cloudinary.com/dmndhddgf/image/upload/v1669981076/development/Badges_1_cxbraw.png" alt=""></img>`,`<img src="https://res.cloudinary.com/dmndhddgf/image/upload/v1669981079/development/Badges_2_rrxvil.png" alt=""></img>`,
    `<img src="https://res.cloudinary.com/dmndhddgf/image/upload/v1669981082/development/Badges_3_pjuj8b.png" alt=""></img>`,`<img src="https://res.cloudinary.com/dmndhddgf/image/upload/v1669981192/development/Badges_last_kdbz6c.png" alt=""></img>`]
    let count = 1
    allCards.forEach((card) => {
      if ( count >= 4) {
        let number = `<p>${count}</p>`;
        card.innerHTML = "";
        card.insertAdjacentHTML("beforeend", images[3]);
        card.insertAdjacentHTML("beforeend", number);
      } else {
        let number = `<p>${count}</p>`;
        card.innerHTML = "";
        card.insertAdjacentHTML("beforeend", images[count-1]);
        card.insertAdjacentHTML("beforeend", number);
      }
      count += 1;
    });

    let id = event.item.dataset.id
    let data = new FormData()
    data.append("position", event.newIndex)

    Rails.ajax({
      url: this.data.get("url").replace(":id", id),
      type: 'PATCH',
      data: data
    })
  }
 }
