// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie-model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) {
  return Movie(
    userId: json['userId'] as String,
    movieId: json['movieId'] as int,
    movieTitle: json['movieTitle'] as String,
    directorName: json['directorName'] as String,
    rating: json['rating'] as int,
    genre: _$enumDecodeNullable(_$GenreEnumMap, json['genre']),
    posterPath: json['posterPath'] as String,
  );
}

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'userId': instance.userId,
      'movieId': instance.movieId,
      'movieTitle': instance.movieTitle,
      'directorName': instance.directorName,
      'rating': instance.rating,
      'posterPath': instance.posterPath,
      'genre': _$GenreEnumMap[instance.genre],
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$GenreEnumMap = {
  Genre.action: 'action',
  Genre.comedy: 'comedy',
  Genre.sitcom: 'sitcom',
  Genre.reality: 'reality',
};
