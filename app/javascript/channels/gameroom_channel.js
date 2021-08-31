import consumer from './consumer';

const initGameroomCable = () => {
  const playersContainer = document.getElementById('players-list');
  // console.log(playersContainer);
  if (playersContainer) {
    const id = playersContainer.dataset.gameId;
    consumer.subscriptions.create(
      { channel: 'GameroomChannel', id: id },
      {
        received(data) {
          playersContainer.outerHTML = data;
          // console.log(data); // called when data is broadcast in the cable
        },
      }
    );
  }
};

export { initGameroomCable };
