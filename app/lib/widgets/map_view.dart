import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../features/taps/tap.dart';
import '../features/taps/tap_detail_sheet.dart';

typedef TapCallback = void Function(LatLng position);

/// Nur die reine Karten-Darstellung
class MapView extends StatelessWidget {
  final List<Tap> taps;
  final TapCallback? onTap;

  const MapView({super.key, required this.taps, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: const LatLng(51.1657, 10.4515), // Mitte Deutschland
        initialZoom: 5,
        onTap: (tapPosition, point) {
          if (onTap != null) {
            onTap!(point);
          }
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.tapmap',
        ),
        MarkerLayer(
          markers: taps.map((tap) {
            return Marker(
              point: LatLng(tap.lat, tap.lon),
              width: 40,
              height: 40,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    builder: (_) => TapDetailSheet(tap: tap),
                  );
                },
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
