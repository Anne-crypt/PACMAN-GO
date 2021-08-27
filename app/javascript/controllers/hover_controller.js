import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['hostSelect', 'guestSelect'];

  // connect() {
  //   console.log('Hello from your first Stimulus controller');
  // }

  // select(event) {
  //   if (event.currentTarget.dataset.role == 'guest') {
  //     this.generatedTarget.classList.add('d-none');
  //     this.tokenTarget.classList.remove('d-none');
  //   } else {
  //     console.log('Hello world!');
  //   }
  // }

  select(event) {
    if (event.currentTarget.dataset.role == 'guest') {
      event.currentTarget.classList.remove('settings-hover-black');
      event.currentTarget.classList.add('settings-hover');
      this.hostSelectTarget.classList.remove('settings-hover');
    } else {
      event.currentTarget.classList.add('settings-hover');
      this.guestSelectTarget.classList.add('settings-hover-black');
    }
  }
}
