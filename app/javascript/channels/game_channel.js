import consumer from './consumer';
import { updateMarkers } from '../plugins/update_markers';

const initGameCable = () => {
  const usersContainer = document.getElementById('userplayer');
  if (usersContainer) {
    const id = usersContainer.dataset.gameId;

    consumer.subscriptions.create(
      { channel: 'GameChannel', id: id },
      {
        received(data) {
          const userPlayer = document.getElementById(`player-${data.id}`);
          const dataNew = JSON.stringify(data);
          userPlayer.dataset.player = dataNew;
          updateMarkers(data.id, data.longitude, data.latitude);
        },
      }
    );
  }
};

export { initGameCable };
