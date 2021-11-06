import 'package:get/get.dart';
import 'package:poc_yellowc/screens/movie-description.dart';
import 'package:poc_yellowc/screens/movies-list.dart';
import 'package:poc_yellowc/screens/populate-movie.dart';
import 'package:poc_yellowc/screens/splash-screen.dart';
import 'package:poc_yellowc/screens/user-authentication.dart';

import 'routes.dart';

class AppPages {

  static final pages = [
    GetPage(name: Routes.INITIAL, page: () => SplashScreen()),
    GetPage(name: Routes.AUTHENTICATION, page: () => UserAuthentication()),
    GetPage(name: Routes.MOVIES_LIST, page: () => MoviesList()),
    GetPage(name: Routes.MOVIES_DESCRIPTION, page: () => MovieDescription()),
    GetPage(name: Routes.POPULATE_MOVIE, page: () => PopulateMovie()),
  ];

}