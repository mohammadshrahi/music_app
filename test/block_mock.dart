import 'package:bloc_test/bloc_test.dart';
import 'package:music_app/presentation/blocs/albums/bloc/top_albums_bloc.dart';
import 'package:music_app/presentation/blocs/artists/bloc/artists_bloc.dart';
import 'package:music_app/presentation/blocs/favorite_albums/bloc/favorite_albums_bloc.dart';
import 'package:music_app/presentation/blocs/tracks/bloc/tracks_bloc.dart';

class MockFavoriteAlbumsBloc
    extends MockBloc<FavoriteAlbumsEvent, FavoriteAlbumsState>
    implements FavoriteAlbumsBloc {}

class MockArtistsBloc extends MockBloc<ArtistsEvent, ArtistsState>
    implements ArtistsBloc {}

class MockTopAlbumsBloc extends MockBloc<TopAlbumsEvent, TopAlbumsState>
    implements TopAlbumsBloc {}

class MockTracksBloc extends MockBloc<TracksEvent, TracksState>
    implements TracksBloc {}
