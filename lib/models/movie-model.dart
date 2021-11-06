import 'package:json_annotation/json_annotation.dart';
import 'package:poc_yellowc/constants/enums.dart';

part 'movie-model.g.dart';

@JsonSerializable()
class Movie {

  final String userId;
  final int movieId;
  final String movieTitle;
  final String directorName;
  final int rating;
  final String posterPath;
  final Genre genre;

  Movie({this.userId, this.movieId, this.movieTitle, this.directorName, this.rating, this.genre, this.posterPath});

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);

}