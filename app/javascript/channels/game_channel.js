import consumer from './consumer';

const initGameCable = () => {
  const playersContainer = document.getElementById('nickname-setting');
  // console.log(playersContainer);
  if (playersContainer) {
    const id = playersContainer.dataset.gameId;
    consumer.subscriptions.create(
      { channel: 'GameChannel', id: id },
      {
        received(data) {
          playerContainer.insertAdjacentHTML('beforeend', data);
          // console.log(data); // called when data is broadcast in the cable
        },
      }
    );
  }
};

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
