import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const initMarkers = () => {
  const mapElement = document.getElementById('gamemap');
  if (mapElement) {
    window.currentMarkers =[];
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    window.map = new mapboxgl.Map({
      container: 'gamemap',
      style: 'mapbox://styles/ja-dore/cksojgcmr4th017lw0hrh1fiz',
      // style: 'mapbox://styles/mapbox/streets-v11',
      center: [2.379983, 48.865171],
      zoom: 16,
      attributionControl: false,
      interactive: false,
    });
  }
};

export { initMarkers };
