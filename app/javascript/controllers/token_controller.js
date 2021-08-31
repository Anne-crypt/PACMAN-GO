// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['token'];

  select(event) {
    if (event.currentTarget.dataset.role == 'guest') {
      // this.generatedTarget.classList.add('visibility_token');
      this.tokenTarget.classList.remove('visibility_token');
    } else {
      this.tokenTarget.classList.add('visibility_token');
      // this.generatedTarget.classList.remove('visibility_token');
    }
  }
}
