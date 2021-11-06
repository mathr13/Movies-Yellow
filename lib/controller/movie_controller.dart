import 'package:shared_preferences/shared_preferences.dart';

import 'package:get/get.dart';
import 'package:poc_yellowc/constants/labels.dart';
import 'package:poc_yellowc/models/movie-model.dart';
import 'package:poc_yellowc/services/database-services.dart';

class MovieController extends GetxController {

  final DatabaseServices _databaseServices = DatabaseServices();
  var progressLoader = false.obs;

  List<Movie> movies = [];

  MovieController() {
    initiateDatabaseSystem();
  }

  // Note: Initiates both database instance and data tables
  initiateDatabaseSystem() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      _databaseServices.initiateDatabase(ValueLabels.DATABASE_NAME).then(
        (isOpen) {
          if(sharedPreferences.getBool(ValueLabels.APP_INSTANTIATED) == null)
            _databaseServices.initialiseTables().then(
              (status) => sharedPreferences.setBool(ValueLabels.APP_INSTANTIATED, true)
            );
        }
      );
  }

  Future<bool> addMovieToDatabase(Movie movie) async {
    progressLoader.value = true;
    int id = await _databaseServices.insertObjectToTable(ValueLabels.MOVIES_TABLE, movie.toJson());
    progressLoader.value = false;
    return id == null ? false : true;
  }

  Future<bool> updateMovieInDatabase(Movie movie) async {
    progressLoader.value = true;
    int id = await _databaseServices.updateRecordInTable(ValueLabels.MOVIES_TABLE, movie.toJson(), {"movieId": movie.movieId, "userId": movie.userId});
    progressLoader.value = false;
    return id != null;
  }

  Future<bool> deleteMovieFromDatabase(Movie movie) async {
    progressLoader.value = true;
    int numbOfRowsAffected = await _databaseServices.removeRecordFromDatabase(ValueLabels.MOVIES_TABLE, {"movieId": movie.movieId, "userId": movie.userId});
    progressLoader.value = false;
    return numbOfRowsAffected != null;
  }

  fetchAllMovies(String userId) async {
    progressLoader.value = true;
    List moviesList = await _databaseServices.fetchAllRecordsFromDatabase(ValueLabels.MOVIES_TABLE, {"userId": userId});
    movies = moviesList.map((movie) => Movie.fromJson(movie)).toList();
    progressLoader.value = false;
  }

}