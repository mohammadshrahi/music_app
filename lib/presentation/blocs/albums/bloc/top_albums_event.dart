part of 'top_albums_bloc.dart';

abstract class TopAlbumsEvent extends Equatable {
  const TopAlbumsEvent();

  @override
  List<Object> get props => [];
}

class TopAlbumsGetEvent extends TopAlbumsEvent {
  TopAlbumsGetEvent(this.artist, {this.withLoading = true});
  Artist artist;
  bool withLoading;
}
