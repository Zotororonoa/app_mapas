import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1Ijoiem90bzE5OTgiLCJhIjoiY2xvb3RxeXFrMDM2bzJrbzdhMXk4bWE1NiJ9.HvveZUcjGyb9ZCBJDnCziw';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

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

//Este es el Widget, por lo que entendi adentro debe llevar 
//cualquier cosa que se pueda scrollear (DraggableScrollableSheet)

//El resto ocurre en los marcadores abajito 

void _showBottomSheet(BuildContext context, String markerName) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true, // Esto permite que el BottomSheet se mueva pa arriba
    builder: (BuildContext context) {
      return DraggableScrollableSheet(
        expand: false,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Text('Bottom Sheet Content for $markerName'),
              ),
            ),
          );
        },
      );
    },
  );
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
            child: Icon(estado),
            onTap: () {
              setState(() => id = 'mapbox/navigation-night-v1');
              setState(() => estado = Icons.sunny);
            },
            onDoubleTap: () {
              setState(() => id = 'mapbox/streets-v12');
              setState(() => estado = Icons.nightlight);
            },
          ),
          const SizedBox(
            width: 40,
          )
        ],
      ),
      body: myPosition == null
          ? const CircularProgressIndicator()
          : FlutterMap(
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
                    'id': id,
                  },
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: myPosition!,
                      width: 90,
                      height: 90,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'My Position');
                        },
                        child: Image.asset('lib/assets/goingmerry.png'),
                      ),
                    ),
                    Marker(
                      point: const LatLng(-35.432460926832505, -71.63051261296629),
                      width: 90,
                      height: 90,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Marker 2');
                        },
                        child: Image.asset('lib/assets/polloKFC.png'),
                      ),
                    ),
                    
                  ],
                ),
              ],
            ),
    );
  }
}

