import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/spot.dart';
import '../repositories/spot_repository.dart';

final spotRepositoryProvider = Provider((ref) => SpotRepository());

final spotsProvider = FutureProvider.family<List<Spot>, Map<String, double>>((
  ref,
  bbox,
) async {
  final repo = ref.watch(spotRepositoryProvider);
  return repo.fetchSpots(
    bbox['minLat']!,
    bbox['minLon']!,
    bbox['maxLat']!,
    bbox['maxLon']!,
  );
});
