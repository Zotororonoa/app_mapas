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

'''
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
'''

### Arquitectura:


