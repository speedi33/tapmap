import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'features/location/location_provider.dart';

void main() {
  runApp(const ProviderScope(child: TapMapApp()));
}

class TapMapApp extends StatelessWidget {
  const TapMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TapMap',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const MapPage(),
    );
  }
}

class MapPage extends ConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = ref.watch(locationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("TapMap")),
      body: location.when(
        data: (pos) {
          if (pos == null) {
            return const Center(child: Text("Standort nicht verfügbar"));
          }

          final userLatLng = LatLng(pos.latitude, pos.longitude);

          return FlutterMap(
            options: MapOptions(initialCenter: userLatLng, initialZoom: 15),
            children: [
              TileLayer(
                urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: userLatLng,
                    width: 40,
                    height: 40,
                    child: const Icon(
                      Icons.location_pin,
                      color: Colors.red,
                      size: 40,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Fehler: $e")),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Platzhalter für Brunnen hinzufügen
        },
        child: const Icon(Icons.add_location_alt),
      ),
    );
  }
}
