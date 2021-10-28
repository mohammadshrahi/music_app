import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_app/data/model/artist/artist_search_response.dart';
import 'package:music_app/domin/usecases/artists/search_for_artist_params.dart';
// import 'package:mocktail/mocktail.dart';
import 'package:music_app/generated/app_text.dart';
import 'package:music_app/presentation/blocs/artists/bloc/artists_bloc.dart';
import 'package:music_app/presentation/blocs/favorite_albums/bloc/favorite_albums_bloc.dart';
import 'package:music_app/presentation/pages/home_page.dart';
import 'package:music_app/presentation/pages/search_page.dart';
import '../../block_mock.dart';
import '../../utils/utils.dart';

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Search Page', () {
    var state = ArtistSearchSucccssState([
      ArtistModel(
        name: 'akon',
        mbid: '1231',
      )
    ]);
    var successEmptyState = FavoriteAlbumsSuccessState([
      // AlbumModel(
      //     albumImage: 'album image',
      //     name: 'All eyes on me',
      //     mbid: '123',
      //     playcount: 12313)
    ]);
    setUpAll(() async {
      registerFallbackValue<ArtistSearchSucccssState>(state);
      registerFallbackValue<ArtistsSearchEvent>(
          ArtistsSearchEvent(SearchForArtistParams('')));
      registerFallbackValue<FavoriteAlbumsState>(successEmptyState);
      registerFallbackValue<FavoriteAlbumsEvent>(FavoriteAlbumsGetEvent());

      HttpOverrides.global = null;
    });

    testWidgets('Show success list data', (WidgetTester tester) async {
      ArtistsBloc artistBloc = MockArtistsBloc();
      MockFavoriteAlbumsBloc favoriteAlbumsBloc = MockFavoriteAlbumsBloc();
      when(() => favoriteAlbumsBloc.state).thenReturn(successEmptyState);

      when(() => artistBloc.state).thenReturn(state);
      await tester.pumpWidget(
          MyMaterialApp(BlocProvider<FavoriteAlbumsBloc>(
            create: (context) => favoriteAlbumsBloc,
            child: BlocProvider<ArtistsBloc>(
              create: (context) => artistBloc,
              child: SearchPage(),
            ),
          )),
          null,
          EnginePhase.build);
      await tester.pumpAndSettle();
      // expect(find.byKey(ValueKey('AppLoadingState')), findsOneWidget);
      expect(find.text('akon'), findsOneWidget);
    });
    testWidgets('Show Loading widget', (WidgetTester tester) async {
      ArtistsBloc artistBloc = MockArtistsBloc();
      MockFavoriteAlbumsBloc favoriteAlbumsBloc = MockFavoriteAlbumsBloc();
      when(() => favoriteAlbumsBloc.state).thenReturn(successEmptyState);

      when(() => artistBloc.state).thenReturn(ArtistSearchLoadingState());
      await tester.pumpWidget(
          MyMaterialApp(BlocProvider<FavoriteAlbumsBloc>(
            create: (context) => favoriteAlbumsBloc,
            child: BlocProvider<ArtistsBloc>(
              create: (context) => artistBloc,
              child: SearchPage(),
            ),
          )),
          null,
          EnginePhase.build);
      expect(find.byKey(ValueKey('AppLoadingState')), findsOneWidget);
    });
  });
}
