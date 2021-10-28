import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:music_app/core/resource/resource.dart';
import 'package:music_app/data/model/artist/artist_search_response.dart';
import 'package:music_app/domin/usecases/artists/search_for_artist_params.dart';
// import 'package:mocktail/mocktail.dart';
import 'package:music_app/generated/app_text.dart';
import 'package:music_app/presentation/blocs/albums/bloc/top_albums_bloc.dart';
import 'package:music_app/presentation/blocs/favorite_albums/bloc/favorite_albums_bloc.dart';
import 'package:music_app/presentation/pages/search_page.dart';
import 'package:music_app/presentation/pages/top_albums_page.dart';
import 'package:music_app/presentation/widgets/album_widget.dart';
import '../../block_mock.dart';
import '../../utils/utils.dart';
import 'package:music_app/data/model/artist/get_top_albums_response.dart';

main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  group('Search Page', () {
    var state = TopAlbumsSuccessState(SuccessResource([
      AlbumModel(
          isFavorite: false,
          albumImage: 'album image',
          name: 'All eyes on me',
          mbid: '123',
          playcount: 12313),
    ]));
    var successEmptyState = FavoriteAlbumsSuccessState([]);
    setUpAll(() async {
      registerFallbackValue<TopAlbumsSuccessState>(state);
      registerFallbackValue<TopAlbumsGetEvent>(
          TopAlbumsGetEvent(ArtistModel()));
      registerFallbackValue<FavoriteAlbumsState>(successEmptyState);
      registerFallbackValue<FavoriteAlbumsEvent>(FavoriteAlbumsGetEvent());

      HttpOverrides.global = null;
    });

    testWidgets('Show success list data', (WidgetTester tester) async {
      TopAlbumsBloc topAlbumsBloc = MockTopAlbumsBloc();
      MockFavoriteAlbumsBloc favoriteAlbumsBloc = MockFavoriteAlbumsBloc();
      when(() => favoriteAlbumsBloc.state).thenReturn(successEmptyState);

      when(() => topAlbumsBloc.state).thenReturn(state);

      await tester.pumpWidget(
        MyMaterialApp(BlocProvider<FavoriteAlbumsBloc>(
          create: (context) => favoriteAlbumsBloc,
          child: BlocProvider<TopAlbumsBloc>(
            create: (context) => topAlbumsBloc,
            child: TopAlbumPage(),
          ),
        )),
      );

      await tester.pumpAndSettle();
      expect(find.byType(AlbumsWidget), findsOneWidget);
      expect(find.text('All eyes on me'), findsOneWidget);
    });
    testWidgets('Show Loading widget', (WidgetTester tester) async {
      TopAlbumsBloc topAlbumsBloc = MockTopAlbumsBloc();
      MockFavoriteAlbumsBloc favoriteAlbumsBloc = MockFavoriteAlbumsBloc();
      when(() => favoriteAlbumsBloc.state).thenReturn(successEmptyState);

      when(() => topAlbumsBloc.state).thenReturn(TopAlbumsLoadingState());
      final key = GlobalKey<NavigatorState>();

      await tester.pumpWidget(
        MyMaterialApp(
          BlocProvider<FavoriteAlbumsBloc>(
            create: (context) => favoriteAlbumsBloc,
            child: BlocProvider<TopAlbumsBloc>(
                create: (context) => topAlbumsBloc, child: TopAlbumPage()),
          ),
        ),
      );

      expect(find.byKey(ValueKey('AppLoadingState')), findsOneWidget);
    });
  });
}
