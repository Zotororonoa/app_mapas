import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_finder/back/token.txt';
import 'package:shop_finder/back/images.dart';
import 'package:shop_finder/back/descripciones.dart';

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
          expand:
              false, // Permitir que el BottomSheet se desplace más arriba en la pantalla
          builder: (BuildContext context, ScrollController scrollController) {
            return Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Establecer el ancho de pantalla disponible
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
        title: const Text('Shop Finder'),
        backgroundColor: Colors.blueAccent,
        actions: [
          GestureDetector(
            child: Icon(estado),
            onTap: () {
              setState(() {
                id = (id == 'mapbox/streets-v12')
                    ? 'mapbox/navigation-night-v1'
                    : 'mapbox/streets-v12';
                estado = (id == 'mapbox/streets-v12')
                    ? Icons.nightlight
                    : Icons.sunny;
              });
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
                        child: Image.asset('assets/green.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.42538619431709, -71.65655862634684),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Falabella');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.427400072669165, -71.64634110877468),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(
                              context, 'Hospital Regional de Talca');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.42332995721795, -71.65941854905245),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'RocaDragon');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.425405777961885, -71.65977317671307),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Plus Ultra');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.427445970248115, -71.65438237147075),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Mall Portal Centro');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.4266023247774, -71.65853979539249),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'McDonald´s');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.430169291605296, -71.64755321063052),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(
                              context, 'Terminal de buses de Talca');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.43302572167493, -71.63098520551083),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(
                              context, 'Plaza Maule Shopping Center');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.43078625204517, -71.62997254106317),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Paris Talca');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.42049339263229, -71.64917594708807),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Nutre Y Entrena');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.42711168452206, -71.65226585192406),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Oxford Talca');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.42328523950442, -71.66505583452582),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Monky Coffee');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.42860071437428, -71.65248163901525),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Chile Baterias Talca 2');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                    Marker(
                      point:
                          const LatLng(-35.426480686250194, -71.6498477097226),
                      width: 30,
                      height: 30,
                      child: GestureDetector(
                        onTap: () {
                          _showBottomSheet(context, 'Telesonido');
                        },
                        child: Image.asset('assets/red.png'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
