import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapWidget extends StatelessWidget {
  const MapWidget({
    Key? key,
    this.position,
    required this.onMapCreated,
    required this.markers,
    required this.polylines,
  }) : super(key: key);

  final CameraPosition? position;
  final Function(GoogleMapController)? onMapCreated;
  final Set<Marker> markers;
  final Map<PolylineId, Polyline> polylines;
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition:
          position ?? const CameraPosition(target: LatLng(0, 0), zoom: 18),
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      mapType: MapType.normal,
      zoomGesturesEnabled: true,
      zoomControlsEnabled: false,
      onMapCreated: (GoogleMapController mapController) {
        onMapCreated?.call(mapController);
      },
      markers: markers,
      polylines: Set<Polyline>.of(polylines.values),
    );
  }
}
