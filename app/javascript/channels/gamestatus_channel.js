import consumer from './consumer';

const initGamestatusCable = () => {
  const usersContainer = document.getElementById('gamestatus');
  if (usersContainer) {
    const id = usersContainer.dataset.gameId;
    consumer.subscriptions.create(
      { channel: 'GamestatusChannel', id: id },
      {
        received(data) {
          window.location = `/games/${id}`;
        },
      }
    );
  }
};

export { initGamestatusCable };
