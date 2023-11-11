import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1Ijoiem90bzE5OTgiLCJhIjoiY2xvb3RxeXFrMDM2bzJrbzdhMXk4bWE1NiJ9.HvveZUcjGyb9ZCBJDnCziw';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? myPosition;

  Future<Position> determinePosition() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('error');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Mapa'),
          backgroundColor: Colors.blueAccent,
        ),
        body:  myPosition == null
          ? const CircularProgressIndicator()
          :FlutterMap(
          options: MapOptions(
              initialCenter: myPosition!,
              minZoom: 5,
              maxZoom: 25,
              initialZoom: 10),
          children: [
            TileLayer(
              urlTemplate:
                  'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
              additionalOptions: const {
                'accessToken': MAPBOX_ACCESS_TOKEN,
                'id': 'mapbox/streets-v12'
              },
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: myPosition!,
                  width: 40,
                  height: 40,
                  child: Image.asset('lib/assets/sunny.png'),
                ),
                Marker(
                  point: const LatLng(-35.428815, -71.659349),
                  width: 40,
                  height: 40,
                  child: Image.asset('lib/assets/Donas.png'), 
                )
              ],
            ),
          ],
        ));
  }
}
