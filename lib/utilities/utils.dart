import 'dart:io';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:poc_yellowc/constants/constants.dart';

String getNameInitials(String fullName) {
  List<String> splitted = fullName.split(" ");
  return splitted.first[0].toUpperCase() + splitted.last[0].toUpperCase();
}

Future<Uint8List> convertImageToBase64(File imageFile) async {
  Uint8List imageAsByteArray = await imageFile.readAsBytes();
  return imageAsByteArray;
}

File convertBase64StringToImage(Uint8List imageByteArray) {
  File result = File.fromRawPath(imageByteArray);
  return result;
}

Widget getSvgFromAssets(String path) {
  return SvgPicture.asset(ValueLabels.ASSET_PREFIX+path, height: 24, fit: BoxFit.scaleDown,);
}