import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_app/core/resource/resource.dart';
import 'package:music_app/data/model/artist/artist_search_response.dart';
import 'package:music_app/domin/entities/album.dart';
import 'package:music_app/domin/entities/artist.dart';
import 'package:music_app/domin/usecases/artists/get_top_albums.dart';
import 'package:music_app/presentation/blocs/albums/bloc/top_albums_bloc.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:music_app/data/model/artist/get_top_albums_response.dart';
import '../../block_mock.dart';
import '../../mock.mocks.dart';

main() {
  GetTopAlbums getTopAlbums = MockGetTopAlbums();
  TopAlbumsBloc topAlbumsBloc = TopAlbumsBloc(getTopAlbums);
  Artist artist = ArtistModel(mbid: '1');

  group('Albums Bloc', () {
    setUpAll(() {
      List<Album> albums = [
        AlbumModel(
          artist: artist,
        )
      ];
      when(getTopAlbums.call(params: artist)).thenAnswer((realInvocation) =>
          Future.value(SuccessResource<List<Album>>(albums)));
    });
    test('Inital State ', () {
      expect(topAlbumsBloc.state, isA<TopAlbumsInitial>());
    });
    blocTest('Loading/Success State when requset top Albums',
        build: () => TopAlbumsBloc(getTopAlbums),
        act: (TopAlbumsBloc bloc) => bloc.getTopAlbumsEvent(artist),
        expect: () =>
            [isA<TopAlbumsLoadingState>(), isA<TopAlbumsSuccessState>()]);

    blocTest('Success State without loading when requset top Albums',
        build: () => TopAlbumsBloc(getTopAlbums),
        seed: () => TopAlbumsInitial() as TopAlbumsState,
        act: (TopAlbumsBloc bloc) =>
            bloc.getTopAlbumsEvent(artist, withLoading: false),
        expect: () => [isA<TopAlbumsSuccessState>()]);
    blocTest('Success State without loading when requset top Albums',
        build: () => TopAlbumsBloc(getTopAlbums),
        seed: () =>
            TopAlbumsSuccessState(SuccessResource([])) as TopAlbumsState,
        act: (TopAlbumsBloc bloc) =>
            bloc.getTopAlbumsEvent(artist, withLoading: false),
        expect: () => [isA<TopAlbumsSuccessState>()]);
  });
}
