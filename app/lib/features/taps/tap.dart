import 'package:hive/hive.dart';

part 'tap.g.dart';

@HiveType(typeId: 0)
class Tap extends HiveObject {
  @HiveField(0)
  double lat;

  @HiveField(1)
  double lon;

  @HiveField(2)
  String name;

  @HiveField(3)
  String description;

  @HiveField(4)
  String? imagePath;

  Tap({
    required this.lat,
    required this.lon,
    required this.name,
    required this.description,
    this.imagePath,
  });
}
