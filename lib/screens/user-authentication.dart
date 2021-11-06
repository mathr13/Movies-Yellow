import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_yellowc/constants/constants.dart';
import 'package:poc_yellowc/controller/movie_controller.dart';

import 'package:poc_yellowc/controller/user-controller.dart';
import 'package:poc_yellowc/utilities/utils.dart';

class UserAuthentication extends StatefulWidget {

  @override State<StatefulWidget> createState() => _UserAuthenticationState();
}

class _UserAuthenticationState extends State<UserAuthentication> {

  UserController _userController = Get.find();
  MovieController _movieController = Get.find();

  String get userId => _userController.googleUser.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.PRIMARY_BACKGROUND,
      body: Center(
        child: Column(
          children: [
            Spacer(flex: 3,),
            Text(
              DisplayLabels.APP_NAME,
              style: TextStyles.appLogo,
            ),
            Spacer(flex: 3,),
            googleSignInButton(),
            skipButton(),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget googleSignInButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiuses.BORDER_RADIUS1,
        color: Colours.PRIMARY_TEXT
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              child: getSvgFromAssets(SvgAssets.GOOGLE_LOGO),
            ),
            Text(
              DisplayLabels.SIGNIN_WITH_GOOGLE,
              style: TextStyles.GOOGLE_SIGNIN,
            ).withPad(Paddings.PADDING1),
          ],
        ),
      ),
    ).onTap(() => implementSignIn()).withPad(Paddings.PADDING1).withPad(Paddings.PADDING1);
  }

  Widget skipButton() {
    return Container(
      child: Text(
        DisplayLabels.SKIP,
        style: TextStyles.UNDERLINED_BUTTON,
      ).withPad(Paddings.HORIZONTAL_PADDING1).withPad(Paddings.VERTICAL_PADDING3),
    ).onTap(() => Get.back());
  }

  implementSignIn() async {
    bool userStatus = await _userController.signIn();
    if(userStatus) {
      _movieController.fetchAllMovies(userId);
      Get.back();
    } else
      Get.showSnackbar(Snackbars.errorBar(ValueLabels.LOGIN_FAILED));
  }
  
}