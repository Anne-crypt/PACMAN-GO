import consumer from './consumer';

const initParticipationCable = () => {
  const playersContainer = document.getElementById('players-list');
  console.log(playersContainer);
  if (playersContainer) {
    const id = playersContainer.dataset.participationId;
    consumer.subscriptions.create(
      { channel: 'ParticipationChannel', id: id },
      {
        received(data) {
          playersContainer.innerHTML = data;
          // console.log(data); // called when data is broadcast in the cable
        },
      }
    );
  }
};

export { initParticipationCable };
