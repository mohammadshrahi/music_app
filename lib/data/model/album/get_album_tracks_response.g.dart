// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_album_tracks_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAlbumTracksResponse _$GetAlbumTracksResponseFromJson(
        Map<String, dynamic> json) =>
    GetAlbumTracksResponse(
      album: json['album'] == null
          ? null
          : AlbumDetails.fromJson(json['album'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAlbumTracksResponseToJson(
        GetAlbumTracksResponse instance) =>
    <String, dynamic>{
      'album': instance.album,
    };

AlbumDetails _$AlbumDetailsFromJson(Map<String, dynamic> json) => AlbumDetails(
      tracks: json['tracks'] == null
          ? null
          : TraksHolder.fromJson(json['tracks'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AlbumDetailsToJson(AlbumDetails instance) =>
    <String, dynamic>{
      'tracks': instance.tracks,
    };

TraksHolder _$TraksHolderFromJson(Map<String, dynamic> json) => TraksHolder(
      track: (json['track'] as List<dynamic>?)
          ?.map((e) => TrackModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TraksHolderToJson(TraksHolder instance) =>
    <String, dynamic>{
      'track': instance.track,
    };

TrackModel _$TrackModelFromJson(Map<String, dynamic> json) => TrackModel(
      duration: json['duration'] as int?,
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$TrackModelToJson(TrackModel instance) =>
    <String, dynamic>{
      'duration': instance.duration,
      'name': instance.name,
      'url': instance.url,
    };
