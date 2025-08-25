import '../models/spot.dart';

class SpotRepository {
  Future<List<Spot>> fetchSpots(
    double minLat,
    double minLon,
    double maxLat,
    double maxLon,
  ) async {
    // TODO: API Call via Dio
    // Dummy-Daten vorerst
    return [
      Spot(
        id: '1',
        name: 'Fountain A',
        lat: minLat + 0.001,
        lon: minLon + 0.001,
        status: 'ok',
      ),
      Spot(
        id: '2',
        name: 'Fountain B',
        lat: minLat + 0.002,
        lon: minLon + 0.002,
        status: 'broken',
      ),
    ];
  }
}
