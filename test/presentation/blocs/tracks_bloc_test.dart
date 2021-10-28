import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_app/core/resource/resource.dart';
import 'package:music_app/core/state/state_types.dart';
import 'package:music_app/data/model/album/get_album_tracks_response.dart';
import 'package:music_app/domin/entities/album.dart';
import 'package:music_app/domin/usecases/albums/get_album_track.dart';
import 'package:music_app/presentation/blocs/tracks/bloc/tracks_bloc.dart';

import '../../mock.mocks.dart';
import 'package:music_app/data/model/artist/get_top_albums_response.dart';

void main() {
  group('Tracks Bloc', () {
    GetAlbumTracks getAlbumTracks = MockGetAlbumTracks();
    Album album = AlbumModel(mbid: '123', name: 'all eyes on me');
    test('init state', () {
      expect(TracksBloc(getAlbumTracks).state, isA<TracksInitial>());
      expect(TracksBloc(getAlbumTracks).state, isA<Loadable>());
    });
    setUpAll(() {
      when(getAlbumTracks.call(params: album)).thenAnswer((real) =>
          Future.value(SuccessResource([TrackModel(name: 'track 1')])));
    });
    blocTest('Get Album Tracks',
        build: () => TracksBloc(getAlbumTracks),
        seed: () => TracksInitial() as TracksState,
        act: (TracksBloc bloc) => bloc.getTracks(album),
        expect: () => [isA<TracksSuccessState>(), isA<TracksSuccessState>()]);
  });
}
