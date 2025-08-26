import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:latlong2/latlong.dart';
import 'features/taps/tap_form.dart';
import 'features/taps/tap_provider.dart';
import 'features/taps/tap.dart';
import 'widgets/map_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(TapAdapter());

  await Hive.openBox<Tap>('taps');

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
    final taps = ref.watch(tapsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('TapMap')),
      body: MapView(
        taps: taps,
        onTap: (LatLng position) {
          showModalBottomSheet(
            context: context,
            builder: (_) => TapForm(
              initialPosition: position,
              onSave: (tap) {
                ref.read(tapsProvider.notifier).addTap(tap);
              },
            ),
          );
        },
      ),
    );
  }
}
