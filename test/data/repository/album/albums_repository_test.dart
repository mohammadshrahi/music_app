import 'dart:ffi';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_app/core/resource/resource.dart';
import 'package:music_app/data/datasources/local/app_database.dart';
import 'package:music_app/data/datasources/remote/music_service.dart';
import 'package:music_app/data/model/album/get_album_tracks_response.dart';
import 'package:music_app/data/model/artist/artist_search_response.dart';
import 'package:music_app/data/repositories/albums/albums_repository.dart';
import 'package:music_app/domin/entities/album.dart';
import 'package:music_app/data/model/artist/get_top_albums_response.dart';
import '../../../mock.mocks.dart';
import '../../../utils/utils.dart';

main() {
  String mbid = '1';
  String artist = '2';
  MusicService musicService = MockMusicService();
  AppDataBase appDataBase = MockAppDataBase();
  GetAlbumTracksResponse getAlbumTracksResponse = GetAlbumTracksResponse(
      album: AlbumDetails(
          tracks: TraksHolder(track: [
    TrackModel(name: 'track 1', duration: 301, url: 'url'),
    TrackModel(name: 'track 2', duration: 301, url: 'url')
  ])));
  Album album =
      AlbumModel(isFavorite: false, mbid: '1', artist: ArtistModel(mbid: '2'));
  AlbumsRepositoryImpl albumsRepositoryImpl =
      AlbumsRepositoryImpl(appDataBase, musicService);

  group('Albums Repository', () {
    test('Return Album Tracks Data when the call success', () async {
      when(musicService.getAlbumTracks(mbid, artist)).thenAnswer(
          (realInvocation) => Future.value(
              ResponseUtils<GetAlbumTracksResponse>()
                  .getSuccssResponse(getAlbumTracksResponse)));
      when(appDataBase.addTracks(
              getAlbumTracksResponse.album?.tracks?.track! as List<TrackModel>,
              album as AlbumModel))
          .thenAnswer((realInvocation) => Future<void>.value());
      var resource = await albumsRepositoryImpl.getAlbumTracks(album);
      expect(resource, isA<SuccessResource>());

      expect(
          (resource as SuccessResource<Album>).data.tracks?[0].name, 'track 1');
      verify(musicService.getAlbumTracks(mbid, artist)).called(1);

      /// Album is not favorite, so we don't need to save the tracks
      verifyNever(
          appDataBase.addTracks(album.tracks as List<TrackModel>, album));
    });
    test('Delete album', () async {
      expect(await albumsRepositoryImpl.deleteAlbum(album),
          isA<SuccessResource>());
      verify(appDataBase.deleteAlbum(album as AlbumModel)).called(1);
    });
    test('Save album', () async {
      expect(
          await albumsRepositoryImpl.saveAlbum(album), isA<SuccessResource>());
      verify(appDataBase.saveAlbum(album as AlbumModel)).called(1);
    });

    test('get favorite albums', () async {
      when(appDataBase.getFavoritesAlbums())
          .thenAnswer((realInvocation) => Future.value([]));

      expect(await albumsRepositoryImpl.getFavoritesAlbums(),
          isA<SuccessResource>());
      verify(appDataBase.getFavoritesAlbums()).called(1);
    });
  });
}
