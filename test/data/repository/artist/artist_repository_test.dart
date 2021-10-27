import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_app/core/resource/resource.dart';
import 'package:music_app/data/datasources/local/app_database.dart';
import 'package:music_app/data/datasources/remote/music_service.dart';
import 'package:music_app/data/model/artist/artist_search_response.dart';
import 'package:music_app/data/repositories/artist/artist_repository.dart';
import 'package:music_app/domin/entities/album.dart';
import 'package:music_app/domin/entities/artist.dart';
import 'package:music_app/domin/usecases/artists/search_for_artist_params.dart';
import 'package:music_app/data/model/artist/get_top_albums_response.dart';
import '../../../mock.mocks.dart';
import '../../../utils/utils.dart';

main() {
  MusicService musicService = MockMusicService();
  AppDataBase appDataBase = MockAppDataBase();
  ArtistRepositoryImpl artistRepositoryImpl =
      ArtistRepositoryImpl(musicService, appDataBase);

  String artist = 'eminem';
  SearchForArtistParams searchForArtistParams = SearchForArtistParams(artist);
  group('Artists Repository', () {
    test('search for artist', () async {
      when(musicService.searchForArtist(artist)).thenAnswer((realInvocation) =>
          Future.value(ResponseUtils<ArtistSearchResponse>().getSuccssResponse(
              ArtistSearchResponse(
                  results: Result(
                      artistMatches: ArtistMatches(
                          artist: [ArtistModel(name: artist, mbid: '1')]))))));
      Resource resource =
          await artistRepositoryImpl.searchForArtist(searchForArtistParams);
      expect(resource, isA<SuccessResource<List<Artist>>>());
      verify(musicService.searchForArtist(artist)).called(1);
    });
    test('Get Top Albums', () async {
      String albumMbid = 'albumMbid';
      var artist = ArtistModel(mbid: '123', name: 'Akon');
      when(musicService.getTopAlbums(artist.mbid!)).thenAnswer(
          (realInvocation) => Future.value(ResponseUtils<GetTopAlbumsResponse>()
              .getSuccssResponse(GetTopAlbumsResponse(
                  topAlbums: TopAlbums(
                      album: [AlbumModel(mbid: albumMbid, artist: artist)])))));
      when(appDataBase.getFavoritesAlbums()).thenAnswer((realInvocation) =>
          Future.value([
            AlbumModel(mbid: albumMbid, artist: ArtistModel(mbid: artist.mbid!))
          ]));
      Resource resource = await artistRepositoryImpl.getTopAlbums(artist);
      expect(resource, isA<SuccessResource<List<Album>>>());
      expect((resource as SuccessResource<List<Album>>).data[0].artist?.mbid!,
          artist.mbid);
      verify(musicService.getTopAlbums(artist.mbid!)).called(1);
      verify(appDataBase.getFavoritesAlbums()).called(1);
    });
  });
}
