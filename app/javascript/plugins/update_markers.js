import mapboxgl from '!mapbox-gl';
import 'mapbox-gl/dist/mapbox-gl.css';

const updateMarkers = (id, long, lat) => {
  const oldmarker = window.currentMarkers[id];
  const element = oldmarker.getElement();
  oldmarker.remove()
  const newmarker = new mapboxgl.Marker(element)
      .setLngLat([long, lat])
      .addTo(window.map);
  window.currentMarkers[id] = newmarker;
};

export { updateMarkers } ;
