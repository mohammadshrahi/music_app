import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_app/core/resource/resource.dart';
import 'package:music_app/data/model/artist/artist_search_response.dart';
import 'package:music_app/domin/entities/album.dart';
import 'package:music_app/domin/usecases/favorite_albums/add_album_to_favorite_list.dart';
import 'package:music_app/domin/usecases/favorite_albums/delete_album_from_favorite_list.dart';
import 'package:music_app/presentation/blocs/favorite_albums/bloc/favorite_albums_bloc.dart';

import '../../mock.mocks.dart';
import 'package:music_app/data/model/artist/get_top_albums_response.dart';

main() {
  AddAlbumFromFavoriteList addAlbumFromFavoriteList =
      MockAddAlbumFromFavoriteList();
  DeleteAlbumFromFavoriteList deleteAlbumFromFavoriteList =
      MockDeleteAlbumFromFavoriteList();
  MockGetFavoriteAlbums getFavoriteAlbums = MockGetFavoriteAlbums();

  Album album = AlbumModel(mbid: '123132');
  group('Favorite items bloc', () {
    setUpAll(() {
      when(getFavoriteAlbums.call()).thenAnswer((realInvocation) =>
          Future.value(SuccessResource([AlbumModel(artist: ArtistModel())])));
      when(addAlbumFromFavoriteList.call(params: album))
          .thenAnswer((realInvocation) => Future.value(SuccessResource(true)));
      when(deleteAlbumFromFavoriteList.call(params: album))
          .thenAnswer((realInvocation) => Future.value(SuccessResource(true)));
    });
    blocTest('get favorite items success',
        build: () => FavoriteAlbumsBloc(addAlbumFromFavoriteList,
            deleteAlbumFromFavoriteList, getFavoriteAlbums),
        seed: () => FavoriteAlbumsInitial() as FavoriteAlbumsState,
        act: (FavoriteAlbumsBloc bloc) => bloc.getAllFavAlbums(),
        expect: () => [isA<FavoriteAlbumsSuccessState>()]);
    blocTest('add Album success',
        build: () => FavoriteAlbumsBloc(addAlbumFromFavoriteList,
            deleteAlbumFromFavoriteList, getFavoriteAlbums),
        seed: () => FavoriteAlbumsInitial() as FavoriteAlbumsState,
        act: (FavoriteAlbumsBloc bloc) => bloc.addAlbum(album),
        expect: () => [isA<FavoriteAlbumsSuccessState>()]);
    blocTest('delete Album success',
        build: () => FavoriteAlbumsBloc(addAlbumFromFavoriteList,
            deleteAlbumFromFavoriteList, getFavoriteAlbums),
        seed: () => FavoriteAlbumsInitial() as FavoriteAlbumsState,
        act: (FavoriteAlbumsBloc bloc) => bloc.deleteAlbum(album),
        expect: () => [isA<FavoriteAlbumsSuccessState>()]);
  });
  group('Favorite item failed Scinarios', () {
    setUpAll(() {
      when(getFavoriteAlbums.call()).thenAnswer((realInvocation) =>
          Future.value(SuccessResource([AlbumModel(artist: ArtistModel())])));
      when(addAlbumFromFavoriteList.call(params: album))
          .thenAnswer((realInvocation) => Future.value(FailedResource(true)));
      when(deleteAlbumFromFavoriteList.call(params: album))
          .thenAnswer((realInvocation) => Future.value(SuccessResource(true)));
    });
    blocTest('delete Album failed',
        build: () => FavoriteAlbumsBloc(addAlbumFromFavoriteList,
            deleteAlbumFromFavoriteList, getFavoriteAlbums),
        seed: () => FavoriteAlbumsInitial() as FavoriteAlbumsState,
        act: (FavoriteAlbumsBloc bloc) => bloc.addAlbum(album),
        expect: () => []);
  });
}
