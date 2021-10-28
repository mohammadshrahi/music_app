import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_app/core/resource/resource.dart';
import 'package:music_app/data/model/artist/artist_search_response.dart';
import 'package:music_app/domin/entities/artist.dart';
import 'package:music_app/domin/usecases/artists/search_for_artist.dart';
import 'package:music_app/domin/usecases/artists/search_for_artist_params.dart';
import 'package:music_app/presentation/blocs/artists/bloc/artists_bloc.dart';

import '../../mock.mocks.dart';

main() {
  SearchForArtist searchForArtist = MockSearchForArtist();

  group('Artist bloc', () {
    setUpAll(() {
      when(searchForArtist.call(params: SearchForArtistParams('Sia')))
          .thenAnswer((realInvocation) => Future.value(SuccessResource([
                ArtistModel(
                  image: [],
                  name: 'Sia',
                  mbid: 'mbid',
                ) as Artist
              ])));
    });
    blocTest('Search for Artist success',
        build: () => ArtistsBloc(searchForArtist),
        seed: () => ArtistsInitial() as ArtistsState,
        act: (ArtistsBloc bloc) => bloc.addSearchForArtist('Sia'),
        expect: () =>
            [isA<ArtistSearchLoadingState>(), isA<ArtistSearchSucccssState>()]);
  });
}
