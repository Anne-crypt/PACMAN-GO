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
