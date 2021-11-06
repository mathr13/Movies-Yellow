import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_yellowc/constants/constants.dart';
import 'package:poc_yellowc/constants/widgets/app-bar.dart';
import 'package:poc_yellowc/constants/widgets/gap.dart';
import 'package:poc_yellowc/controller/movie_controller.dart';
import 'package:poc_yellowc/controller/user-controller.dart';
import 'package:poc_yellowc/models/movie-model.dart';
import 'package:poc_yellowc/navigation/routes.dart';

class MoviesList extends StatefulWidget {
  @override State<StatefulWidget> createState() => _MoviesList();
}

class _MoviesList extends State<MoviesList> {

  MovieController _movieController = Get.find();
  UserController _userController = Get.find();
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool get isUserPersisted => _userController.isUserAuthenticated;
  String get fullName => isUserPersisted ? _userController.googleUser.displayName : "";
  String get userImageUrl => isUserPersisted ? _userController.googleUser.photoUrl : "";
  String get userId => _userController.googleUser?.id ?? "";
  void get openUserDrawer => _key.currentState.openDrawer();

  @override
  void initState() {
    _movieController.fetchAllMovies(userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: getAppBarWidget(DisplayLabels.APP_NAME, style: TextStyles.appLogo, actions: appBarActions(), leading: getProfileSummaryWidget()),
        backgroundColor: Colours.PRIMARY_BACKGROUND,
        key: _key,
        drawer: getDrawerWidget(),
        body: _movieController.movies.length > 0
          ? ListView.builder(
              itemCount: _movieController.movies.length,
              itemBuilder: (context, index) => movieItem(_movieController.movies[index]),
            ).withPad(Paddings.TOP_PADDING1)
          : getEmptyWidget(),
      ).withProgressIndicator(_movieController.progressLoader.value || _userController.progressLoader.value),
    );
  }

  Widget movieItem(Movie movie) {
    return Container(
      decoration: BoxDecoration(
        color: Colours.SECONDARY_BACKGROUND,
        borderRadius: BorderRadiuses.BORDER_RADIUS2
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: Radiuses.IMAGE_AVATAR*2/3,
            backgroundImage: FileImage(File(movie.posterPath)),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.movieTitle,
                style: TextStyles.ROW_CELL_TITLE,
              ),
              gap(height: 16),
              Text(
                movie.directorName,
                style: TextStyles.ROW_CELL_SUBTITLE,
              )
            ],
          ).withPad(Paddings.PADDING1),
        ],
      ).withPad(Paddings.HORIZONTAL_PADDING1),
    ).withPad(Paddings.HORIZONTAL_PADDING1).withPad(Paddings.VERTICAL_PADDING2).onTap(
      () => Get.toNamed(Routes.POPULATE_MOVIE, arguments: CustomArguments(
        movie: movie
      ))
    );
  }

  Widget getEmptyWidget() {
    return Center(
      child: Column(
        children: [
          Spacer(),
          Image.asset(ValueLabels.ASSET_PREFIX+ImageAssets.EMPTY_BOX, color: Colours.PRIMARY_TEXT,),
          gap(height: 16),
          Text(
            DisplayLabels.NO_MOVIES_FOUND,
            style: TextStyles.LIGHTSUBTITLE1,
          ),
          Spacer(),
          isUserPersisted
            ? RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: DisplayLabels.GO_AHEAD_MESSAGE,
                      style: TextStyles.LIGHTSUBTITLE1,
                    ),
                    TextSpan(
                      text: DisplayLabels.ADD_MOVIE.toLowerCase(),
                      style: TextStyles.UNDERLINED_BUTTON,
                    ),
                    TextSpan(
                      text: DisplayLabels.ADD_NEW_MOVIE_MESSAGE,
                      style: TextStyles.LIGHTSUBTITLE1,
                    )
                  ]
                ),
              ).onTap(() => Get.toNamed(Routes.POPULATE_MOVIE))
            : RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: DisplayLabels.GO_AHEAD_MESSAGE+DisplayLabels.START_BY,
                      style: TextStyles.LIGHTSUBTITLE1,
                    ),
                    TextSpan(
                      text: DisplayLabels.LOGGING_IN.toLowerCase(),
                      style: TextStyles.UNDERLINED_BUTTON,
                    ),
                  ]
                ),
              ).onTap(() => openUserDrawer),
          Spacer(flex: 2,),
        ],
      ),
    ).withPad(Paddings.PADDING1);
  }

  List<Widget> appBarActions() {
    return [
      Icon(
        Icons.add,
        size: SIZES.DEF_ICON_SIZE,
        color: Colours.PRIMARY_BUTTON_TEXT,
      ).withPad(
        Paddings.HORIZONTAL_PADDING1
      ).onTap(
        () => isUserPersisted
          ? Get.toNamed(Routes.POPULATE_MOVIE)
          : Get.toNamed(Routes.AUTHENTICATION)
      ),
    ];
  }

  Widget getDrawerWidget() {
    return Drawer(
      child: Container(
        color: Colours.SECONDARY_BACKGROUND,
        child: SafeArea(
          child: Column(
            children: isUserPersisted
              ? [
                  CircleAvatar(
                    radius: Radiuses.IMAGE_AVATAR,
                    backgroundColor: Colours.PRIMARY_BACKGROUND,
                    child: ClipRRect(
                      borderRadius: BorderRadiuses.IMAGE_BORDERRADIUS1,
                      child: Image.network(userImageUrl)
                    ),
                  ).withPad(Paddings.PADDING1),
                  Center(
                    child: Text(
                      fullName,
                      style: TextStyles.ROW_CELL_TITLE,
                    ),
                  ).withPad(Paddings.PADDING1),
                  Spacer(),
                  getLogOutButton()
                ]
              : [
                  Spacer(),
                  Center(
                    child: Text(
                      DisplayLabels.MISSING_OUT,
                      style: TextStyles.decoratedText1,
                    ),
                  ).withPad(Paddings.PADDING1),
                  Spacer(),
                  googleSignInButton(),
              ],
          ).withPad(Paddings.PADDING1),
        ),
      ),
    );
  }

  Widget getLogOutButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiuses.BORDER_RADIUS1,
        color: Colours.PRIMARY_TEXT
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DisplayLabels.LOGOUT,
              style: TextStyles.GOOGLE_SIGNIN,
            ).withPad(Paddings.PADDING1),
          ],
        ),
      ),
    ).onTap(() => implementSignOut()).withPad(Paddings.HORIZONTAL_PADDING1);
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
            Text(
              DisplayLabels.LOGIN,
              style: TextStyles.GOOGLE_SIGNIN,
            ).withPad(Paddings.PADDING1),
          ],
        ),
      ),
    ).onTap(() => {Get.back(), Get.toNamed(Routes.AUTHENTICATION)}).withPad(Paddings.PADDING1);
  }

  Widget getProfileSummaryWidget() {
    if(isUserPersisted)
      return CircleAvatar(
        backgroundColor: Colours.PRIMARY_TEXT,
        child: ClipRRect(
          borderRadius: BorderRadiuses.IMAGE_BORDERRADIUS1,
          child: Image.network(userImageUrl)
        ),
      ).onTap(() => openUserDrawer).withPad(Paddings.LEFT_PADDING2);
    else
      return Icon(
        Icons.menu,
        size: SIZES.DEF_ICON_SIZE,
      ).onTap(() => openUserDrawer);
  }

  implementSignOut() async {
    bool userStatus = await _userController.signOut();
    _movieController.fetchAllMovies(userId);
    if(userStatus) {
      _movieController.fetchAllMovies(userId);
      Get.back();
    } else
      Get.showSnackbar(Snackbars.errorBar(ValueLabels.LOGOUT_FAILED));
  }

}