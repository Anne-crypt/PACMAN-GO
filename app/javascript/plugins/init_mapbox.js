import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';
import { csrfToken } from "@rails/ujs";

const initMapbox = () => {
  const mapElement = document.getElementById('gamemap');

  if (mapElement) {
    const currentPlayerId = parseInt(mapElement.dataset.currentUser);
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

    const elements = document.querySelectorAll('.player-container')
    elements.forEach((element) => {
        const player = JSON.parse(element.dataset.player);
        // currentMarkers[player.id].remove();
        element.className = 'marker';
        element.style.backgroundImage = `url('https://placekitten.com/g/25/25/')`;
        element.style.backgroundSize = 'contain';
        element.style.width = '25px';
        element.style.height = '25px';
        let marker = new mapboxgl.Marker(element)
          .setLngLat([ player.longitude, player.latitude ])
          .addTo(window.map);
        window.currentMarkers[player.id] = marker;
        });

    const markers = JSON.parse(mapElement.dataset.markers);
    console.log(markers)
    markers.forEach((marker) => {
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.backgroundRepeat = 'no-repeat';
      element.style.width = '25px';
      element.style.height = '25px';
      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(window.map);
    });

    if (navigator.geolocation) {
      navigator.geolocation.watchPosition((position) => {
        console.log(position.coords.longitude)
        fetch(`/games/4/players/${currentPlayerId}`, {
          method: 'PATCH',
          headers: { 'Content-Type': "application/json", 'X-CSRF-Token': csrfToken()
        },
          body: JSON.stringify({ longitude: position.coords.longitude, latitude: position.coords.latitude})
        })
      })
  }}
};

export { initMapbox };
