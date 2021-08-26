import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['pacmanIcon', 'ghostIcon'];

  // connect() {
  //   console.log('Hello from your first Stimulus controller');
  // }

  select(event) {
    // console.log(event);
    const ghosts = document.querySelectorAll('.ghost-object');
    const pacmans = document.querySelectorAll('.pacman-object');
    if (event.currentTarget.dataset.role == 'pacman') {
      pacmans.forEach((pacman) => {
        pacman.classList.remove('settings-hover');
      });
      event.currentTarget.classList.add('settings-hover');
      document
        .getElementById('player_pacman')
        .setAttribute('value', event.currentTarget.dataset.id);
      ghosts.forEach((ghost) => {
        ghost.classList.add('settings-hover');
      });
      this.ghostIconTarget.classList.remove('settings-hover');
    } else {
      event.currentTarget.classList.add('settings-hover');
      this.pacmanIconTarget.classList.remove('settings-hover');
      pacmans.item(0).classList.add('settings-hover');
      ghosts.item(0).classList.remove('settings-hover');
      document
        .getElementById('player_pacman')
        .setAttribute('value', pacmans.item(0).dataset.id);
    }
  }
}
