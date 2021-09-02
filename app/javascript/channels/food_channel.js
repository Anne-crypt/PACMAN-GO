import consumer from './consumer';

const initFoodCable = () => {
  const markerContainer = document.getElementById('markeritem');

  if (markerContainer) {
    const id = markerContainer.dataset.gameId;

    consumer.subscriptions.create(
      { channel: 'FoodChannel', id: id },
      {
        received(data) {
          data[0].forEach(item => {
            const itemMarker = document.getElementById(`item-${item.id}`);
            itemMarker.hidden = true;
          });

          const score = document.getElementById('game_score');
          score.innerHTML = `Score: ${data[1]}`;
        },
      }
    );
  }
};

export { initFoodCable };
