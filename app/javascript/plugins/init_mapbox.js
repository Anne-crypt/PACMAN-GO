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
    console.log(currentPlayerId);
    console.log(pacmanId);
    let counter = 0;
    // only build a map if there's a div#map to inject into
    // mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    // const map = new mapboxgl.Map({
      //   container: 'gamemap',
      //   // style: 'mapbox://styles/ja-dore/cksojgcmr4th017lw0hrh1fiz',
      //   style: 'mapbox://styles/mapbox/streets-v11',
      //   center: [2.379983, 48.865171],
      //   zoom: 16,
      //   attributionControl: false,
      //   interactive: false,
      // });

    const playerElements = document.querySelectorAll('.player-container');
    playerElements.forEach((element) => {
        const player = JSON.parse(element.dataset.player);
        console.log(player);
        const imageUrl = element.dataset.image;
        element.className = 'marker';
        element.style.backgroundImage = `url('${imageUrl}')`;
        element.style.backgroundSize = 'contain';
        element.style.width = '25px';
        element.style.height = '25px';
        let marker = new mapboxgl.Marker(element)
          .setLngLat([ player.longitude, player.latitude ])
          .addTo(window.map);
        window.currentMarkers[player.id] = marker;
        });

      // if(currentPlayerId == pacmanId){
      const itemsElements = document.querySelectorAll('.item-container');
      itemsElements.forEach((element) => {
        const item = JSON.parse(element.dataset.item);
        console.log(item);
        const imageUrl = element.dataset.image;
        element.className = 'marker';
        element.style.backgroundImage = `url('${imageUrl}')`;
        element.style.backgroundSize = 'contain';
        element.style.backgroundRepeat = 'no-repeat';
        element.style.width = '25px';
        element.style.height = '25px';
        let marker = new mapboxgl.Marker(element)
          .setLngLat([ item.longitude, item.latitude ])
          .addTo(window.map);
      });
    // }

   const setGeolocation = () => {
      if (navigator.geolocation) {
        navigator.geolocation.watchPosition((position) => {
          console.log(position.coords.longitude)

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
      setTimeout(setGeolocation(), 10000);
      counter ++;
      console.log(counter);
    }
  }
};

export { initMapbox };
