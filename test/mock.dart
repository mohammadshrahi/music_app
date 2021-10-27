import 'package:mockito/annotations.dart';
import 'package:music_app/data/datasources/local/app_database.dart';
import 'package:music_app/data/datasources/remote/music_service.dart';
import 'package:music_app/domin/repositories/albums_repository.dart';
import 'package:music_app/domin/repositories/artist_repository.dart';
import 'package:music_app/domin/usecases/albums/get_album_track.dart';
import 'package:music_app/domin/usecases/artists/get_top_albums.dart';
import 'package:music_app/domin/usecases/artists/search_for_artist.dart';
import 'package:music_app/domin/usecases/favorite_albums/add_album_to_favorite_list.dart';
import 'package:music_app/domin/usecases/favorite_albums/delete_album_from_favorite_list.dart';
import 'package:music_app/domin/usecases/favorite_albums/get_favorite_albums.dart';
import 'mock.mocks.dart';

@GenerateMocks([
  AlbumsRepository,
  ArtistRepository,
  MusicService,
  GetAlbumTracks,
  GetTopAlbums,
  SearchForArtist,
  AddAlbumFromFavoriteList,
  DeleteAlbumFromFavoriteList,
  GetFavoriteAlbums,
  AppDataBase
])
class AppTestMock {
  static AlbumsRepository getAlbumsRepository() {
    return MockAlbumsRepository();
  }

  static ArtistRepository getArtistRepository() {
    return MockArtistRepository();
  }

  static MusicService getMusicService() {
    return MockMusicService();
  }

  static GetAlbumTracks getGetAlbumTracks() {
    return MockGetAlbumTracks();
  }

  static GetTopAlbums getGetTopAlbums() => MockGetTopAlbums();

  static SearchForArtist getSearchForArtist() => MockSearchForArtist();

  static AddAlbumFromFavoriteList getAddAlbumFromFavoriteList() =>
      MockAddAlbumFromFavoriteList();

  static DeleteAlbumFromFavoriteList getDeleteAlbumFromFavoriteList() =>
      MockDeleteAlbumFromFavoriteList();

  static GetFavoriteAlbums getGetFavoriteAlbums() => MockGetFavoriteAlbums();
}
