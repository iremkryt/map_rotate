import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Rota Çizimi',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _firstLocate = CameraPosition(
    target: LatLng(41.206145, 32.659303),
    zoom: 14.4746,
  );

  static final Marker _firstLocateMarker = Marker(
    markerId: MarkerId('_firstLocate'),
    infoWindow: InfoWindow(title: 'Buradayim'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(41.206145, 32.659303),

  );
  static const CameraPosition _secondLocate = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(41.218807, 32.659832),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

    static final Marker _secondLocateMarker = Marker(
      markerId: MarkerId('_secondLocate'),
      infoWindow: InfoWindow(title: 'Güneş Market'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(41.218807, 32.659832),
    );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {
          _firstLocateMarker,
          _secondLocateMarker,
          },
        initialCameraPosition: _firstLocate,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheMarket,
        label: const Text('Market'),
        icon: const Icon(Icons.shopping_basket),
      ),
    );
  }

  Future<void> _goToTheMarket() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_secondLocate));
  }
}