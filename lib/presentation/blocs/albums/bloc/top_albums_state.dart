part of 'top_albums_bloc.dart';

abstract class TopAlbumsState extends Equatable {
  const TopAlbumsState();

  @override
  List<Object> get props => [];
}

class TopAlbumsInitial extends TopAlbumsState implements Loadable {}

class TopAlbumsLoadingState extends TopAlbumsState implements Loadable {}

class TopAlbumsFailedState extends TopAlbumsState implements Failable {
  TopAlbumsFailedState(this.failedResource);
  FailedResource failedResource;
  @override
  String getMessage() {
    return failedResource.message ?? '';
  }
}

class TopAlbumsSuccessState extends TopAlbumsState {
  TopAlbumsSuccessState(this.successResource);
  SuccessResource<List<Album>> successResource;
}
