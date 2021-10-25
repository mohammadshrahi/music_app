import 'package:injectable/injectable.dart';
import 'package:music_app/core/resource/http_response_handler.dart';
import 'package:music_app/data/datasources/local/app_database.dart';
import 'package:music_app/data/datasources/remote/music_service.dart';
import 'package:music_app/data/model/album/get_album_tracks_response.dart';
import 'package:music_app/domin/entities/album.dart';
import 'package:music_app/core/resource/resource.dart';
import 'package:music_app/domin/entities/track.dart';
import 'package:music_app/domin/repositories/albums_repository.dart';
import 'package:music_app/data/model/artist/get_top_albums_response.dart';

@LazySingleton(as: AlbumsRepository)
class AlbumsRepositoryImpl implements AlbumsRepository {
  AppDataBase appDataBase;
  MusicService musicService;
  AlbumsRepositoryImpl(this.appDataBase, this.musicService);
  @override
  Future<Resource> deleteAlbum(Album album) async {
    try {
      var box = await appDataBase.getAlbumBox();
      box.deleteAt(box.values.toList().cast().indexOf(album));
      var trackBox = await appDataBase.getTrackBox(album.mbid!);
      var artistBox = await appDataBase.getArtistBox();
      artistBox.delete(album.mbid);
      trackBox.clear();

      return const SuccessResource(true);
    } catch (e) {
      return FailedResource(e);
    }
  }

  @override
  Future<Resource> getFavoritesAlbums() async {
    try {
      var box = await appDataBase.getAlbumBox();
      List<AlbumModel> list = box.values.toList().cast();
      var artistBox = await appDataBase.getArtistBox();

      for (AlbumModel album in list) {
        album.artist = artistBox.get(album.mbid);
        var trackBox = await appDataBase.getTrackBox(album.mbid!);
        album.tracks = trackBox.values.toList().cast();
      }
      return SuccessResource(list);
    } catch (e) {
      return FailedResource(e);
    }
  }

  @override
  Future<Resource> saveAlbum(Album album) async {
    try {
      var box = await appDataBase.getAlbumBox();
      box.add(album as AlbumModel);
      var artistBox = await appDataBase.getArtistBox();
      artistBox.put(album.mbid, album.artist!);
      var trackBox = await appDataBase.getTrackBox(album.mbid!);
      if (album.tracks != null) {
        for (Track t in album.tracks!) {
          trackBox.add(t);
        }
      }

      return const SuccessResource(true);
    } catch (e) {
      return FailedResource(e);
    }
  }

  @override
  Future<Resource> getAlbumTracks(Album album) async {
    Resource resource = await HttpResponseHandler<GetAlbumTracksResponse>()
        .handle(musicService.getAlbumTracks(
            album.mbid ?? '', album.artist?.mbid ?? ''));
    if (resource is SuccessResource<GetAlbumTracksResponse>) {
      // var box = await appDataBase.getAlbumBox();
      album.tracks = resource.data.album?.tracks?.track ?? [];

      if (album.isFavorite ?? false) {
        var box = await appDataBase.getTrackBox(album.mbid!);
        for (Track t in album.tracks!) {
          box.add(t);
        }
      }
      return SuccessResource<Album>(album);
    } else {
      return SuccessResource<Album>(album);
    }
  }
}
