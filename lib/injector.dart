import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import 'package:poc_yellowc/controller/movie_controller.dart';
import 'controller/user-controller.dart';

var getIt = GetIt.I;

inject() {

  Get.put(MovieController());
  Get.put(UserController());

}