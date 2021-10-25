import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import 'package:music_app/data/model/artist/get_top_albums_response.dart';
import 'package:music_app/domin/entities/artist.dart';
import 'package:music_app/domin/entities/track.dart';

@Singleton()
class AppDataBase {
  Future<Box<AlbumModel>> getAlbumBox() async {
    return await Hive.openBox<AlbumModel>('albums');
  }

  Future<Box<Track>> getTrackBox(String albumId) async {
    return await Hive.openBox<Track>(albumId);
  }

  Future<Box<Artist>> getArtistBox() async {
    return await Hive.openBox<Artist>('artists');
  }
}
