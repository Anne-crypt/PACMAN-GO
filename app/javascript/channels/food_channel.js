import consumer from './consumer';

const initFoodCable = () => {
  const markerContainer = document.getElementById('markerItem');
  if (markerContainer) {
    const id = markerContainer.dataset.gameId;

    consumer.subscriptions.create(
      { channel: 'FoodChannel', id: id },
      {
        received(data) {
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
