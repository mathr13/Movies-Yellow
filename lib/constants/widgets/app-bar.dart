import 'package:flutter/material.dart';

import '../colours.dart';
import '../styles.dart';

AppBar getAppBarWidget(String title, {TextStyle style = TextStyles.HEADLINE1, List<Widget> actions, Widget leading}) {
  return AppBar(
    title: Text(
      title,
      style: style,
    ),
    automaticallyImplyLeading: false,
    leading: leading,
    backgroundColor: Colours.PRIMARY_BACKGROUND,
    actions: actions
  );
}