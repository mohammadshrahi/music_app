import 'package:hive/hive.dart';
import 'package:music_app/data/model/artist/artist_search_response.dart';
part 'artist.g.dart';

@HiveType(typeId: 10)
class Artist extends HiveObject {
  Artist({this.listeners, this.mbid, this.name, this.streamable, this.url});
  @HiveField(0)
  String? name;
  @HiveField(2)
  String? listeners;
  @HiveField(3)
  String? mbid;
  @HiveField(4)
  String? url;
  @HiveField(5)
  String? streamable;
}
