import mapboxgl from 'mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const place_marker = (lat, lon, map) => {
  new mapboxgl.Marker().setLngLat([lon, lat]).addTo(map);
  console.log(`test ${lat} ${lon} `)
}

const set_my_position = (location) => {
  const lon = location.coords.longitude;
  const lat = location.coords.latitude;
};

const initMapbox = () => {
  const mapElement = document.getElementById('gamemap');

  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'gamemap',
      style: 'mapbox://styles/ja-dore/cksojgcmr4th017lw0hrh1fiz',
      center: [2.379993, 48.8640313],
      zoom: 15,
      attributionControl: false,
      interactive: false
    });


    const element = document.createElement('div');
    element.className = 'marker';
    element.style.backgroundImage = `url('https://placekitten.com/g/25/25/')`;
    element.style.backgroundSize = 'contain';
    element.style.width = '25px';
    element.style.height = '25px';
    new mapboxgl.Marker(element).setLngLat([2.379993, 48.8640313]).addTo(map);




    if (navigator.geolocation) {
      navigator.geolocation.watchPosition((position) => {
        place_marker(position.coords.latitude, position.coords.longitude, map);
      });
    }
    else {
      console.log("you don't have it ");
    }
  }
};

export { initMapbox };
