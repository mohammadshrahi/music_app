part of 'favorite_albums_bloc.dart';

abstract class FavoriteAlbumsState {
  const FavoriteAlbumsState();
}

class FavoriteAlbumsInitial extends FavoriteAlbumsState implements Loadable {}

///
class FavoriteAlbumsSuccessState extends FavoriteAlbumsState {
  const FavoriteAlbumsSuccessState(this.albums);
  final List<Album> albums;
}
