import 'package:flutter/material.dart';
import 'package:poc_yellowc/constants/styles.dart';
import 'package:poc_yellowc/constants/extensions.dart';

import '../colours.dart';

Widget getButtonWidget(String title, Function implement) {
  return SafeArea(
    child: Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colours.SECONDARY_BACKGROUND,
        borderRadius: BorderRadiuses.BORDER_RADIUS2
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyles.PRIMARY_BUTTON,
        ),
      ),
    ).withPad(Paddings.HORIZONTAL_PADDING1).onTap(implement),
  );
}