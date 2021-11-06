import 'package:json_annotation/json_annotation.dart';

part 'movie-director-model.g.dart';

@JsonSerializable()
class MovieDirector {

  final int directorId;
  final String directorName;

  MovieDirector({this.directorName, this.directorId});

  factory MovieDirector.fromJson(Map<String, dynamic> json) => _$MovieDirectorFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDirectorToJson(this);
}