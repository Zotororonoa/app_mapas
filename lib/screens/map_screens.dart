import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1Ijoiem90bzE5OTgiLCJhIjoiY2xvb3RxeXFrMDM2bzJrbzdhMXk4bWE1NiJ9.HvveZUcjGyb9ZCBJDnCziw';
final MY_POSITION = LatLng(-35.4159, -71.6363);

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Mapa'),
          backgroundColor: Colors.blueAccent,
        ),
        body: FlutterMap(
          options: MapOptions(
              initialCenter: MY_POSITION,
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
                  point: MY_POSITION,
                  width: 40,
                  height: 40,
                  child: FlutterLogo(),
                ),
              ],
            ),
          ],
        ));
  }
}
