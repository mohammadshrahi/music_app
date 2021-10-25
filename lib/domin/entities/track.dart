import 'package:hive/hive.dart';
part 'track.g.dart';

@HiveType(typeId: 15)
class Track {
  @HiveField(0)
  int? duration;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? url;
}
