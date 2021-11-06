import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:poc_yellowc/constants/colours.dart';

extension PaddedWidget on Widget {
  Widget withPad(EdgeInsets padding) {
    return Padding(
      padding: padding,
      child: this,
    );
  }
}

extension OpaqueWidget on Widget {
  Widget withOpacity(double opacity) {
    return Opacity(
      opacity: opacity,
      child: this,
    );
  }
}

extension TappableWidget on Widget {
  Widget onTap(Function onPressed) {
    return GestureDetector(
      child: this,
      onTap: onPressed,
    );
  }
}

extension ObservableWidget on Widget {
  Widget withObserver() => Obx(() => this);
}

extension ProgressIndicator on Widget {
  ModalProgressHUD withProgressIndicator(bool showIndicator) {
    Widget progressIndicator = SpinKitFadingFour(
      color: Colours.PRIMARY_TEXT,
    );
    return ModalProgressHUD(
      progressIndicator: progressIndicator,
      inAsyncCall: showIndicator,
      color: Colours.PRIMARY_BACKGROUND,
      child: this
    );
  }
}