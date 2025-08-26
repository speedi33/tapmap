import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'tap.dart';

final tapBoxProvider = Provider<Box<Tap>>((ref) {
  return Hive.box<Tap>('taps');
});

final tapsProvider = StateNotifierProvider<TapNotifier, List<Tap>>((ref) {
  return TapNotifier();
});

class TapNotifier extends StateNotifier<List<Tap>> {
  TapNotifier() : super([]) {
    _loadTaps();
  }

  Future<void> _loadTaps() async {
    final box = await Hive.openBox<Tap>('taps');
    state = box.values.toList();
  }

  Future<void> addTap(Tap tap) async {
    final box = await Hive.openBox<Tap>('taps');
    await box.add(tap);
    state = [...state, tap];
  }
}
