import { Controller } from 'stimulus';

export default class extends Controller {
  // static targets = ['generated', 'token'];

  connect() {
    console.log('Hello from your first Stimulus controller');
  }

  // select(event) {
  //   if (event.currentTarget.dataset.role == 'guest') {
  //     this.generatedTarget.classList.add('d-none');
  //     this.tokenTarget.classList.remove('d-none');
  //   } else {
  //     this.tokenTarget.classList.add('d-none');
  //     this.generatedTarget.classList.remove('d-none');
  //   }
  // }
}
