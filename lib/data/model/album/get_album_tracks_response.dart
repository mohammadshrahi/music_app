import 'package:json_annotation/json_annotation.dart';
import 'package:music_app/domin/entities/track.dart';
part 'get_album_tracks_response.g.dart';

@JsonSerializable()
class GetAlbumTracksResponse {
  GetAlbumTracksResponse({this.album});
  AlbumDetails? album;
  factory GetAlbumTracksResponse.fromJson(Map<String, dynamic> json) =>
      _$GetAlbumTracksResponseFromJson(json);
}

@JsonSerializable()
class AlbumDetails {
  AlbumDetails({this.tracks});
  factory AlbumDetails.fromJson(Map<String, dynamic> json) =>
      _$AlbumDetailsFromJson(json);

  TraksHolder? tracks;
}

@JsonSerializable()
class TraksHolder {
  TraksHolder({this.track});
  List<TrackModel>? track;
  factory TraksHolder.fromJson(Map<String, dynamic> json) =>
      _$TraksHolderFromJson(json);
}

@JsonSerializable()
class TrackModel implements Track {
  TrackModel({this.duration, this.name, this.url});
  factory TrackModel.fromJson(Map<String, dynamic> json) =>
      _$TrackModelFromJson(json);
  @override
  int? duration;

  @override
  String? name;

  @override
  String? url;
}
