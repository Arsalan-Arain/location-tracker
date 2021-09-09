import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(25.038166, 67.1207438), zoom: 12.0);

  late GoogleMapController _googleMapController;

  late double start_lat, start_lng, end_lat, end_lng;

  Marker _origin = Marker(
    markerId: const MarkerId('origin'),
    infoWindow: const InfoWindow(title: 'Origin'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    position: LatLng(25.046093, 67.109339),
  );
  Marker _destination = Marker(
    markerId: const MarkerId('destination'),
    infoWindow: const InfoWindow(title: 'Destination'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    position: LatLng(25.034503, 67.140083),
  );

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Map'),
        actions: [
          TextButton(
            onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                    target: _origin.position, zoom: 14.5, tilt: 50.0),
              ),
            ),
            style: TextButton.styleFrom(
                primary: Colors.green,
                textStyle: const TextStyle(fontWeight: FontWeight.w600)),
            child: const Text('START'),
          ),
          TextButton(
            onPressed: () => _googleMapController.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: _destination.position,
                  zoom: 14.5,
                  tilt: 50.0,
                ),
              ),
            ),
            style: TextButton.styleFrom(
                primary: Colors.red[800],
                textStyle: const TextStyle(fontWeight: FontWeight.w600)),
            child: const Text('END'),
          ),
        ],
      ),
      body: GoogleMap(
        myLocationButtonEnabled: false,
        zoomControlsEnabled: false,
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: {
          _origin,
          _destination,
        },
        //  onLongPress: _addMarker,
      ),
      // button to re-center location
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(_initialCameraPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
