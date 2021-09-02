import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import { csrfToken } from "@rails/ujs";

const initMapbox = () => {
  const mapElement = document.getElementById('gamemap');

  if (mapElement) {
    const currentPlayerId = parseInt(mapElement.dataset.currentUser);
    const elementGameId = document.getElementById('userplayer');
    const currentGameId = parseInt(elementGameId.dataset.gameId);
    const pacmanId = parseInt(mapElement.dataset.pacmanUser);
    let counter = 0;

    const spElement = document.getElementById('lewagonstart');
    const wagonUrl = spElement.dataset.image
    spElement.className = 'marker';
    spElement.style.backgroundImage = `url('${wagonUrl}')`;
    spElement.style.backgroundSize = 'contain';
    spElement.style.backgroundRepeat = "no-repeat";
    spElement.style.width = '45px';
    spElement.style.height = '45px';
    new mapboxgl.Marker(spElement, { anchor: 'bottom'})
      .setLngLat([2.380197576721457, 48.8649])
      .addTo(window.map);

    const playerElements = document.querySelectorAll('.player-container');
    playerElements.forEach((element) => {
        const player = JSON.parse(element.dataset.player);
        const imageUrl = element.dataset.image;
        element.className = 'marker';
        element.style.backgroundImage = `url('${imageUrl}')`;
        element.style.backgroundSize = 'contain';
        element.style.width = '25px';
        element.style.height = '25px';
        let marker = new mapboxgl.Marker(element)
          .setLngLat([ 0, 0 ])
          .addTo(window.map);
        window.currentMarkers[player.id] = marker;
        });

      // if(currentPlayerId == pacmanId){
      const itemsElements = document.querySelectorAll('.item-container');
      itemsElements.forEach((element) => {
        const item = JSON.parse(element.dataset.item);
        const imageUrl = element.dataset.image;
        element.className = 'marker';
        element.style.backgroundImage = `url('${imageUrl}')`;
        element.style.backgroundSize = 'contain';
        element.style.backgroundRepeat = 'no-repeat';
        element.style.width = '25px';
        element.style.height = '25px';
        new mapboxgl.Marker(element)
          .setLngLat([ item.longitude, item.latitude ])
          .addTo(window.map);
      });
    // }



   const setGeolocation = () => {
      if (navigator.geolocation) {
        navigator.geolocation.watchPosition((position) => {

          fetch(`/games/${currentGameId}/players/${currentPlayerId}`, {
            method: 'PATCH',
            headers: { 'Content-Type': "application/json", 'X-CSRF-Token': csrfToken()
          },
            body: JSON.stringify({ longitude: position.coords.longitude, latitude: position.coords.latitude})
          })
        })
      }
    }

    if (currentPlayerId == pacmanId || counter != 0){
        setGeolocation();
    }
    else {
      setTimeout(function(){ counter ++; setGeolocation()}, 5000);
    }
  }
};

export { initMapbox };
