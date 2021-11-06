import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poc_yellowc/constants/colours.dart';

class TextStyles {

  static const TextStyle HEADLINE1 = TextStyle(
    fontSize: SIZES.HEADLINEFONT1,
    color: Colours.PRIMARY_TEXT
  );

  static const TextStyle HEADLINE2 = TextStyle(
    fontSize: SIZES.HEADLINEFONT2,
    color: Colours.PRIMARY_TEXT
  );

  static const TextStyle HEADLINE3 = TextStyle(
    fontSize: SIZES.HEADLINEFONT25,
    color: Colours.PRIMARY_TEXT
  );

  static const TextStyle LIGHTSUBTITLE1 = TextStyle(
    fontSize: SIZES.HEADLINEFONT3,
    color: Colours.PRIMARY_TEXT
  );

  static const TextStyle LIGHTSUBTITLE2 = TextStyle(
    fontSize: SIZES.HEADLINEFONT4,
    color: Colours.PRIMARY_TEXT
  );

  static const TextStyle DARKSUBTITLE1 = TextStyle(
    fontSize: SIZES.HEADLINEFONT3,
    color: Colours.SECONDARY_TEXT
  );

  static const TextStyle DARKSUBTITLE15 = TextStyle(
    fontSize: SIZES.HEADLINEFONT38,
    color: Colours.PRIMARY_BACKGROUND
  );

  static const TextStyle DARKSUBTITLE2 = TextStyle(
    fontSize: SIZES.HEADLINEFONT4,
    color: Colours.SECONDARY_TEXT
  );

  static const TextStyle REQUIREDFIELD = TextStyle(
    fontSize: SIZES.HEADLINEFONT3,
    color: Colours.REQUIRED
  );

  static const TextStyle PRIMARY_BUTTON = TextStyle(
    fontSize: SIZES.HEADLINEFONT3,
    color: Colours.PRIMARY_BUTTON_TEXT
  );

  static const TextStyle UNDERLINED_BUTTON = TextStyle(
    fontSize: SIZES.HEADLINEFONT3,
    color: Colours.PRIMARY_BUTTON_TEXT,
    decoration: TextDecoration.underline
  );

  static const TextStyle ROW_CELL_TITLE = TextStyle(
    fontSize: SIZES.HEADLINEFONT2,
    color: Colours.PRIMARY_BUTTON_TEXT
  );

  static const TextStyle ROW_CELL_SUBTITLE = TextStyle(
    fontSize: SIZES.HEADLINEFONT3,
    color: Colours.PRIMARY_BUTTON_TEXT
  );

  static const TextStyle GOOGLE_SIGNIN = TextStyle(
    fontSize: SIZES.HEADLINEFONT35,
    color: Colours.SECONDARY_BACKGROUND,
    fontWeight: FontWeight.w600
  );

  static TextStyle decoratedText1 = GoogleFonts.satisfy(
    fontSize: SIZES.HEADER1,
    color: Colours.PRIMARY_TEXT
  );

  static TextStyle appLogo = GoogleFonts.satisfy(
    fontSize: SIZES.HEADLINEFONT1,
    color: Colours.PRIMARY_TEXT
  );

}

class Paddings {

  static const EdgeInsets DIALOG_PADDING1 = EdgeInsets.all(36);

  static const EdgeInsets PADDING1 = EdgeInsets.all(16);
  static const EdgeInsets PADDING2 = EdgeInsets.all(12);
  static const EdgeInsets PADDING3 = EdgeInsets.all(10);
  static const EdgeInsets PADDING4 = EdgeInsets.all(8);
  static const EdgeInsets PADDING5 = EdgeInsets.all(6);
  static const EdgeInsets PADDING6 = EdgeInsets.all(4);

  static const EdgeInsets HORIZONTAL_PADDING1 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets HORIZONTAL_PADDING2 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets HORIZONTAL_PADDING3 = EdgeInsets.symmetric(horizontal: 8);

  static const EdgeInsets VERTICAL_PADDING1 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets VERTICAL_PADDING2 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets VERTICAL_PADDING3 = EdgeInsets.symmetric(vertical: 8);

  static const EdgeInsets BOTTOM_PADDING1 = EdgeInsets.only(bottom: 16);
  static const EdgeInsets BOTTOM_PADDING2 = EdgeInsets.only(bottom: 12);
  static const EdgeInsets BOTTOM_PADDING3 = EdgeInsets.only(bottom: 8);

  static const EdgeInsets TOP_PADDING1 = EdgeInsets.only(top: 16);
  static const EdgeInsets TOP_PADDING2 = EdgeInsets.only(top: 12);
  static const EdgeInsets TOP_PADDING3 = EdgeInsets.only(top: 8);

  static const EdgeInsets LEFT_PADDING1 = EdgeInsets.only(left: 16);
  static const EdgeInsets LEFT_PADDING2 = EdgeInsets.only(left: 12);
  static const EdgeInsets LEFT_PADDING3 = EdgeInsets.only(left: 8);
}

class SIZES {

  static const double HEADER1 = 50;

  static const double HEADLINEFONT1 = 40;
  static const double HEADLINEFONT2 = 30;
  static const double HEADLINEFONT25 = 25;
  static const double HEADLINEFONT3 = 20;
  static const double HEADLINEFONT35 = 18;
  static const double HEADLINEFONT38 = 15;
  static const double HEADLINEFONT4 = 10;

  static const double DEF_ICON_SIZE = 32;

}

class BorderRadiuses {

  static const BorderRadiusGeometry BORDER_RADIUS1 = BorderRadius.all(Radius.circular(30));
  static const BorderRadiusGeometry BORDER_RADIUS2 = BorderRadius.all(Radius.circular(16));
  static const BorderRadiusGeometry BORDER_RADIUS3 = BorderRadius.all(Radius.circular(12));

  static const BorderRadiusGeometry IMAGE_BORDERRADIUS1 = BorderRadius.all(Radius.circular(Radiuses.IMAGE_AVATAR));

}

class Radiuses {
  static const double IMAGE_AVATAR = 60;
}