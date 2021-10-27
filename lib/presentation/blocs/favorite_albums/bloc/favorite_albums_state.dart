part of 'favorite_albums_bloc.dart';

abstract class FavoriteAlbumsState {
  const FavoriteAlbumsState();
}

class FavoriteAlbumsInitial extends FavoriteAlbumsState implements Loadable {}

///
class FavoriteAlbumsSuccessState extends FavoriteAlbumsState {
  FavoriteAlbumsSuccessState(this.albums, {this.deleteFailed, this.saveFailed});
  final List<Album> albums;
  bool? saveFailed;
  bool? deleteFailed;
  FavoriteAlbumsSuccessState copyWith({bool? saveFailed, bool? deleteFailed}) {
    return FavoriteAlbumsSuccessState(albums,
        saveFailed: saveFailed ?? this.saveFailed,
        deleteFailed: deleteFailed ?? this.deleteFailed);
  }
}
