import { Controller } from 'stimulus';
import { csrfToken } from '@rails/ujs';

export default class extends Controller {
  static targets = ['pacmanIcon', 'ghostIcon'];
  static values = { gameUrl: String };

  // connect() {
  //   console.log('Hello from your first Stimulus controller');
  // }

  settings(event) {
    console.log(event);
    // if (event.currentTarget.dataset.role == 'pacman') {
    // }
  }

  select(event) {
    // console.log(event);
    const ghosts = document.querySelectorAll('.ghost-object');
    const pacmans = document.querySelectorAll('.pacman-object');
    if (event.currentTarget.dataset.role == 'pacman') {
      pacmans.forEach((pacman) => {
        pacman.classList.remove('settings-hover');
      });
      event.currentTarget.classList.add('settings-hover');
      // document
      //   .getElementById('player_pacman')
      //   .setAttribute('value', event.currentTarget.dataset.id);
      this.pacmanId = event.currentTarget.dataset.id;

      ghosts.forEach((ghost) => {
        ghost.classList.add('settings-hover');
      });
      this.ghostIconTarget.classList.remove('settings-hover');
    } else {
      event.currentTarget.classList.add('settings-hover');
      this.pacmanIconTarget.classList.remove('settings-hover');
      pacmans.item(0).classList.add('settings-hover');
      ghosts.item(0).classList.remove('settings-hover');
      // document
      //   .getElementById('player_pacman')
      //   .setAttribute('value', pacmans.item(0).dataset.id);
      this.pacmanId = pacmans.item(0).dataset.id;
    }
    var formData = new FormData(); // Currently empty
    formData.append('pacman', this.pacmanId);

    console.log(this.pacmanId);

    fetch(this.gameUrlValue, {
      method: 'PATCH',
      headers: { Accept: 'application/json', 'X-CSRF-Token': csrfToken() },
      body: formData,
    });
  }
}

// fetch appel ajax vers le update game en PATCH
// 2 options:
// 1. on garde un form dans le DOM.
// - on extrait les datas du form et on fait un fetch avec les data

// 2. on a pas de form
// - on construit les params depuis nos data stimulus et on fait un fetch avec ces data

// fetch(XXXX,

//   method: 'PATCH',
//   body: { player: { pacman: player_pacman_id }}
// )
