import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['pacmanIcon', 'ghostIcon'];

  connect() {
    console.log('Hello from your first Stimulus controller');
  }
}

// document
//   .getElementById('player_pacman')
//   .setAttribute('value', event.currentTarget.dataset.id);
