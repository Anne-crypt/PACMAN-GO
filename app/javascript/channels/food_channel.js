import consumer from './consumer';

const initFoodCable = () => {
  const markerContainer = document.getElementById('markeritem');

  if (markerContainer) {
    const id = markerContainer.dataset.gameId;

    consumer.subscriptions.create(
      { channel: 'FoodChannel', id: id },
      {
        received(data) {
          console.log(data);
          const itemMarker = document.getElementById(`item-${data.id}`);
          itemMarker.hidden = true;
          // const dataNew = JSON.stringify(data);
          // itemMarker.dataset.item = dataNew;
        },
      }
    );
  }
};

export { initFoodCable };
