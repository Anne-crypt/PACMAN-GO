import consumer from './consumer';

const initGameCable = () => {
  const playersContainer = document.getElementById('nickname-setting');
  if (playersContainer) {
    const id = playersContainer.dataset.GameId;

    consumer.subscriptions.create(
      { channel: 'GameChannel', id: id },
      {
        received(data) {
          console.log(data); // called when data is broadcast in the cable
        },
      }
    );
  }
};

export { initGameCable };
