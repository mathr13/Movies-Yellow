// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie-director-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieDirector _$MovieDirectorFromJson(Map<String, dynamic> json) {
  return MovieDirector(
    directorName: json['directorName'] as String,
    directorId: json['directorId'] as int,
  );
}

Map<String, dynamic> _$MovieDirectorToJson(MovieDirector instance) =>
    <String, dynamic>{
      'directorId': instance.directorId,
      'directorName': instance.directorName,
    };
