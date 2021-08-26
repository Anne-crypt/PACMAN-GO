import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const placeMarker = (lat, lon, map) => {
  new mapboxgl.Marker().setLngLat([lon, lat]).addTo(map);
 }

const initMapbox = () => {
  const mapElement = document.getElementById('gamemap');


  if (mapElement) { // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'gamemap',
      // style: 'mapbox://styles/ja-dore/cksojgcmr4th017lw0hrh1fiz',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [2.379983, 48.865171],
      zoom: 16,
      attributionControl: false,
      interactive: true,
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      new mapboxgl.Marker(mapelement)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });

    const mapelement = document.createElement('div');
    mapelement.className = 'marker';
    mapelement.style.backgroundImage = "ghost_pink.png";
    mapelement.style.backgroundSize = 'contain';
    mapelement.style.width = '25px';
    mapelement.style.height = '25px';



    if (navigator.geolocation) {
      navigator.geolocation.watchPosition((position) => {
        placeMarker(position.coords.latitude, position.coords.longitude, map);
      });
    }
    else {
      console.log("you don't have it ");
    }
  }
};

export { initMapbox };
