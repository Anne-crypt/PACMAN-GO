import consumer from './consumer';

const initGamestatusCable = () => {
  const usersContainer = document.getElementById('gamestatus');
  if (usersContainer) {
    const id = usersContainer.dataset.gameId;
    console.log('hello', id);

    consumer.subscriptions.create(
      { channel: 'GamestatusChannel', id: id },
      {
        received(data) {
          console.log('hello', data);
          window.location = `/games/${id}`;
        },
      }
    );
  }
};

export { initGamestatusCable };
