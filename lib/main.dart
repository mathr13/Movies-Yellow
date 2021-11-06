import 'package:flutter/material.dart';

import 'injector.dart';
import 'main-movies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await inject();
  runApp(MoviesApp());
}