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

  String id = 'mapbox/streets-v12';

  IconData estado = Icons.nightlight;

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
          title: const Text('Naka-map'),
          backgroundColor: Colors.blueAccent,
          actions: [
            GestureDetector(
              child: Icon(
                estado
              ),
              onTap: (){
                setState(()=> id='mapbox/navigation-night-v1');
                setState(()=> estado= Icons.sunny);
              },
              onDoubleTap: (){
                setState(()=> id='mapbox/streets-v12');
                setState(()=> estado= Icons.nightlight);
              },
            ),
            const SizedBox(
              width: 40,
            )
          ],
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
              additionalOptions: {
                'accessToken': MAPBOX_ACCESS_TOKEN,
                'id': id
              },
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: myPosition!,
                  width: 90,
                  height: 90,
                  child: Image.asset('lib/assets/goingmerry.png'),
                ),
                Marker(
                  point: const LatLng(-35.432460926832505, -71.63051261296629),
                  width: 90,
                  height: 90,
                  child: Image.asset('lib/assets/polloKFC.png'), 
                ),
                 Marker(
                  point: const LatLng(-35.42620576785557, -71.65544307382392),
                  width: 70,
                  height: 70,
                  child: Image.asset('lib/assets/DonasSIR.png'), 
                ),
                Marker(
                  point: const LatLng(-35.428207782099655, -71.66229879996882),
                  width: 70,
                  height: 70,
                  child: Image.asset('lib/assets/SakeMB.png'), 
                ),
                 Marker(
                  point: const LatLng(-35.42330319594781, -71.66184818900518),
                  width: 70,
                  height: 70,
                  child: Image.asset('lib/assets/SakeAGB.png'), 
                ),
                 Marker(
                  point: const LatLng(-35.434504869577985, -71.61708282474858),
                  width: 70,
                  height: 70,
                  child: Image.asset('lib/assets/SakeMPB.png'), 
                ),
                Marker(
                  point: const LatLng(-35.43475236653571, -71.63060786343407),
                  width: 70,
                  height: 70,
                  child: Image.asset('lib/assets/pizzaDP.png'), 
                ),
                Marker(
                  point: const LatLng(-35.43491408600035, -71.62903877120327),
                  width: 70,
                  height: 70,
                  child: Image.asset('lib/assets/pizzaMP.png'), 
                ),
        
              ],
            ),
          ],
        ));
  }
}
