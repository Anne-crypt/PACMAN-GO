import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const placeMarker = (lat, lon, map) => {
  new mapboxgl.Marker().setLngLat([lon, lat]).addTo(map);
};

const initMapbox = () => {
  const mapElement = document.getElementById('gamemap');


  if (mapElement) {
    // only build a map if there's a div#map to inject into
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'gamemap',
      // style: 'mapbox://styles/ja-dore/cksojgcmr4th017lw0hrh1fiz',
      style: 'mapbox://styles/mapbox/streets-v11',
      center: [2.379983, 48.865171],
      zoom: 16,
      attributionControl: false,
      interactive: false,
    });
    const markers = JSON.parse(mapElement.dataset.markers);
    console.log(markers)
    markers.forEach((marker) => {
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';
      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });



    if (navigator.geolocation) {
      navigator.geolocation.watchPosition((position) => {
        placeMarker(position.coords.latitude, position.coords.longitude, map);
      });
    } else {
      console.log("you don't have it ");
    }
  }
};

export { initMapbox };
