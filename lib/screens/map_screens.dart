import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carousel_slider/carousel_slider.dart';

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

  void _showBottomSheet(BuildContext context, String markerName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return DraggableScrollableSheet(
          expand: false, // Permitir que el BottomSheet se desplace más arriba en la pantalla
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              width: MediaQuery.of(context).size.width, // Establecer el ancho de pantalla disponible
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Column(
                    children: [
                      Text('$markerName'),
                      const SizedBox(height: 16),
                      
                      Text(markerDescriptions[markerName] ?? ''),

                      const SizedBox(height: 16),

                      CarouselSlider(
                        options: CarouselOptions(
                          height: 200,
                          enableInfiniteScroll: false,
                        ),
                        items: markerImages[markerName]!.map((imagePath) {
                          return Image.asset(imagePath);
                        }).toList(),
                      ),
                      
                    ],
                  ),
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
        title: const Text('Busca Tienda'),
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
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'My Position');
                        },
                        child: Image.asset('lib/assets/green.png'),
                      ),
                    ),
                    Marker(
                      point: const LatLng(-35.42538619431709, -71.65655862634684),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Falabella');
                        },
                        child: Image.asset('lib/assets/red.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}



  Map<String, List<String>> markerImages = {
    'My Position': [
      'lib/assets/photo1.jpg',
      'lib/assets/photo2.jpg',
      'lib/assets/photo3.jpg',
    ],
    'Falabella': [
      'lib/assets/lugares/falabella1.jfif',
      'lib/assets/lugares/falabella2.jpg',
      'lib/assets/lugares/falabella3.jpg',
    ],
  };


  final Map<String, String> markerDescriptions = {
  'My Position': 'Esta es la descripción para el Marcador 1',
  'Falabella': 'Esta es la descripción para el Marcador 2',
  // Agrega más descripciones aquí
};