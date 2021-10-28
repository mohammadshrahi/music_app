import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
// import 'package:mocktail/mocktail.dart';
import 'package:music_app/generated/app_text.dart';
import 'package:music_app/presentation/blocs/favorite_albums/bloc/favorite_albums_bloc.dart';
import 'package:music_app/data/model/artist/get_top_albums_response.dart';
import 'package:music_app/presentation/pages/home_page.dart';
import '../../block_mock.dart';
import '../../utils/utils.dart';

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Home Page', () {
    var successEmptyState = FavoriteAlbumsSuccessState([
      // AlbumModel(
      //     albumImage: 'album image',
      //     name: 'All eyes on me',
      //     mbid: '123',
      //     playcount: 12313)
    ]);
    var successState = FavoriteAlbumsSuccessState([
      AlbumModel(
          albumImage: 'album image',
          name: 'All eyes on me',
          mbid: '123',
          playcount: 12313)
    ]);

    setUpAll(() async {
      registerFallbackValue<FavoriteAlbumsState>(successEmptyState);
      registerFallbackValue<FavoriteAlbumsEvent>(FavoriteAlbumsGetEvent());
      // HttpOverrides.global = null;
    });
    testWidgets('Show Epmty list text', (WidgetTester tester) async {
      MockFavoriteAlbumsBloc favoriteAlbumsBloc = MockFavoriteAlbumsBloc();
      when(() => favoriteAlbumsBloc.state).thenReturn(successEmptyState);
      await tester.pumpWidget(
          MyMaterialApp(
            BlocProvider<FavoriteAlbumsBloc>(
              create: (context) => favoriteAlbumsBloc,
              child: HomePage(),
            ),
          ),
          null,
          EnginePhase.build);
      await tester.pumpAndSettle();
      expect(find.text('home.no_albums_added'), findsOneWidget);
    });
    testWidgets('Show favoriate list text', (WidgetTester tester) async {
      MockFavoriteAlbumsBloc favoriteAlbumsBloc = MockFavoriteAlbumsBloc();
      when(() => favoriteAlbumsBloc.state).thenReturn(successState);
      await tester.pumpWidget(
          MyMaterialApp(
            BlocProvider<FavoriteAlbumsBloc>(
              create: (context) => favoriteAlbumsBloc,
              child: HomePage(),
            ),
          ),
          null,
          EnginePhase.build);
      await tester.pumpAndSettle();
      expect(find.text('All eyes on me'), findsOneWidget);
    });
  });
}
