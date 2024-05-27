import 'package:getx_weather/model/current_response_model.dart';
import 'package:hive/hive.dart';

part 'hiveDB.g.dart';

@HiveType(typeId: 1)
class HiveDB {
  @HiveField(0)
  Main main;

  @HiveField(1)
  Clouds clouds;

  @HiveField(2)
  Wind wind;

  @HiveField(3)
  List<Weather>? weather;
  HiveDB({
    required this.main,
    required this.clouds,
    required this.weather,
    required this.wind,
  });

  @override
  String toString() {
    return '';
  }
}
