import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'navigation/app-pages.dart';
import 'navigation/routes.dart';

class MoviesApp extends StatefulWidget {
  @override State<StatefulWidget> createState() => _MoviesAppState();
}

class _MoviesAppState extends State<MoviesApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.INITIAL,
      getPages: AppPages.pages,
    );
  }
}