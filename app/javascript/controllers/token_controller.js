// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'generated', 'token' ]


  select(event) {
    if (event.currentTarget.dataset.role == "guest") {
      this.generatedTarget.classList.add('d-none')
      this.tokenTarget.classList.remove('d-none')
    } else {
      this.tokenTarget.classList.add('d-none')
      this.generatedTarget.classList.remove('d-none')
    }
  }
}
