# Evaluación II: Implementación de una característica Flutter

### Nombre del Proyecto:

Implementación de mapa y muestras de ubicaciones.

### Equipo 9:

- Diego Bravo Soto (Desarrollador Principal)
- Francisco González Vidal (Arquitecto de Software)
- Matías Morales Vergara (Encargado de diseño)

### Caso de uso:

Aplicación de mapa en donde se puedan buscar diferentes tipos de locales en su respectiva dirección.

### Diseño:

En el proceso de diseño, se optó por crear una interfaz simple y minimalista, enfocándonos en resaltar la importancia de la implementación del mapa. La simplicidad de la interfaz busca proporcionar a los usuarios una experiencia intuitiva y fácil de usar, permitiéndoles centrarse en la funcionalidad principal de explorar y navegar a través del mapa de manera eficiente. Esta elección de diseño se alinea con la prioridad de destacar las capacidades del mapa, asegurando que la interfaz no distraiga, sino que mejore la experiencia global de la aplicación móvil.

![Maqueta](https://cdn.discordapp.com/attachments/597145376671268874/1173776724375392307/image.png?ex=65652fc2&is=6552bac2&hm=bcb7a384d5e9a0863fc28dd2921cf20da28108451822c516371a6cd1845f372b&)

La dinámica del mapa se inspiró en el mundo del anime One Piece, buscando añadir un toque atractivo a la aplicación para captar la atención de los usuarios. En relación con esta temática, cada ubicación de local marcada en el mapa presenta su propio logo temático relacionado con el anime, proporcionando una experiencia visual única y personalizada. Además, para una identificación rápida, se incorpora el icono de ubicación actual correspondiente a cada usuario, agregando un elemento de interacción en tiempo real. Esta integración de elementos visuales específicos no solo enriquece la apariencia de la aplicación, sino que también infunde un sentido de familiaridad y diversión para los amantes de One Piece, contribuyendo así a una experiencia de usuario memorable y única.

![OnePiece](https://cdn.discordapp.com/attachments/915801301986738237/1173785592748847115/image.png?ex=65653805&is=6552c305&hm=3803e0fd155f9d3fb7c5e06ebb39cbc2e3fb15952d65474e446ba5fc3c48c9ce&)

Y tambien se le agrego un modo oscuro, para la mejorar experiencia del usuario.

### Implementación:

Para comenzar se utilizan las se utilizan las siguientes librerias, para las funciones de mapa, el trabajo con tatitudes y longitudes
y para el uso de GPS.

```
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
```
Se define un token que es necesario para la utilización de la API de MAPBOX y luego se define la clase MapScreen y un estado.

```
const MAPBOX_ACCESS_TOKEN =
    'pk.eyJ1Ijoiem90bzE5OTgiLCJhIjoiY2xvb3RxeXFrMDM2bzJrbzdhMXk4bWE1NiJ9.HvveZUcjGyb9ZCBJDnCziw';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}
```
La implementación comienza declarando la variable myPosition del tipo LatLong para ser usada en la ubicación del dispositivo,
y luego se define un id que se usara para cambiar al modo nocturno del mapa posteriormente finalmente se define un icono con 
forma de luna.

```
class _MapScreenState extends State<MapScreen> {
  LatLng? myPosition;

  String id = 'mapbox/streets-v12';

  IconData estado = Icons.nightlight;
```
    Esta función se usa para preguntar por los permisos del dispositivo.

```
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
```
Con esta funcion se puede capturar la ubicacion del dispositivo.

```
void getCurrentLocation() async {
    Position position = await determinePosition();
    setState(() {
      myPosition = LatLng(position.latitude, position.longitude);
      print(myPosition);
    });
  }
```
Aqui se define la estructura de la barra superior con un botón que puede cambiar el comportamiento de la App.

```
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
```
En esta parte se implementa el mapa y se le dan los valores iniciales.
urlTemplate representa la API que se utiliza y el valor id representa el que tipo de mapa se muestra.

```
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
```
Para finalizar se crean una serie de marcadores para mostrar el mapa, siendo el primero la posición del dispositivo y
los siguientes para mostrar lugares de interes.

```
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
```

### Arquitectura:

La estructura de archivos propuesta para el proyecto se alinea con la arquitectura de software Modelo-Vista-Vistamodelo (MVVM). Esta metodología organiza la lógica de la aplicación en tres capas distintas:

- Modelo: Representa los datos de la aplicación
- Vista: Representa la interfaz de usuario de la aplicación
- Vistamodelo: Actúa como intermediario entre el modelo y la vista.

Dentro de la estructura de carpetas de la aplicación, la carpeta "lib" contiene el código fuente de la aplicación. La subcarpeta "screens" alberga clases que representan las vistas de la aplicación, siendo "map_screens.dart" una de ellas.

La clase "main.dart" funciona como el punto de entrada de la aplicación. Esta clase crea una instancia de "map_screens.dart" y la presenta en pantalla.

La elección de la arquitectura MVVM para nuestra aplicación se justifica por su capacidad para estructuras el código de manera ordenada, mejorando la legilibildad y la mantenibilidad.

![Arquitectura](https://cdn.discordapp.com/attachments/597145376671268874/1173793893024796692/image.png?ex=65653fc0&is=6552cac0&hm=30902e21d4cf5427384ad1a436e06592c205aacd91cd9967c86898022ef4aa26&)


