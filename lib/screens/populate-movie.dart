import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poc_yellowc/constants/constants.dart';
import 'package:poc_yellowc/constants/widgets/app-bar.dart';
import 'package:poc_yellowc/constants/widgets/form-button.dart';
import 'package:poc_yellowc/controller/movie_controller.dart';
import 'package:poc_yellowc/controller/user-controller.dart';
import 'package:poc_yellowc/models/field-card-model.dart';
import 'package:poc_yellowc/models/movie-model.dart';
import 'package:poc_yellowc/utilities/utils.dart';

class PopulateMovie extends StatefulWidget {

  final Movie editMovie;

  PopulateMovie() : this.editMovie = Get.arguments?.movie;

  @override State<StatefulWidget> createState() => _PopulateMovie();

}

class _PopulateMovie extends State<PopulateMovie> {

  List<FieldCard> textFields = [];

  MovieController _movieController = Get.find();
  UserController _userController = Get.find();

  bool get isDescriptionScenario => widget.editMovie != null;
  bool get isImageAvailable => imageFile != null;
  bool get isEditScenario => isDescriptionScenario && isEditingEnabled;
  String get pageTitle => isDescriptionScenario ? (isEditScenario ? DisplayLabels.UPDATE_MOVIE_TITLE : widget.editMovie.movieTitle) : (DisplayLabels.ADD_MOVIE_TITLE);
  String get buttonTitle => isEditScenario ? DisplayLabels.UPDATE_MOVIE : DisplayLabels.SAVE_MOVIE;
  double get imageOpacity => isEditScenario ? 0.25 : 1.0;
  bool get isAddNewScenario => !isDescriptionScenario;
  String get userId => _userController.googleUser?.id ?? "";

  int movieId;
  File imageFile;
  bool isEditingEnabled = false;
  
  bool isFirstItem(int index) => index == 0;

  @override initState() {
    super.initState();
    populateTextFields();
    initiateMovieId();
  }

  initiateMovieId() {
    if(isDescriptionScenario)
      movieId = widget.editMovie.movieId;
    else
      movieId = Random().nextInt(100000);
  }

  populateTextFields() {
    TextEditingController _movieTitleController = TextEditingController();
    TextEditingController _directorNameController = TextEditingController();
    if(isDescriptionScenario) {
      _movieTitleController.text = widget.editMovie.movieTitle;
      _directorNameController.text = widget.editMovie.directorName;
      imageFile = File(widget.editMovie.posterPath);
    }
    textFields.add(
      FieldCard(
        ValueLabels.MOVIE_TEXTFIELD,
        ValueLabels.MOVIE_TEXTFIELD_HINT,
        _movieTitleController,
        Icon(Icons.movie_creation_outlined, color: Colours.PRIMARY_TEXT),
        isMandatory: true,
        errorMessage: DisplayLabels.MOVIE_TITLE_MANDATORY_MESSAGE,
        forDescription: false
      )
    );
    textFields.add(
      FieldCard(
        ValueLabels.DIRECTOR_TEXTFIELD,
        ValueLabels.DIRECTOR_TEXTFIELD_HINT,
        _directorNameController,
        Icon(Icons.linked_camera_rounded, color: Colours.PRIMARY_TEXT),
        isMandatory: true,
        errorMessage: DisplayLabels.DIRECTOR_NAME_MANDATORY_MESSAGE
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.PRIMARY_BACKGROUND,
      appBar: getAppBarWidget(pageTitle, style: TextStyles.HEADLINE3, leading: getLeadingWidget(), actions: appBarActions()),
      body: ListView.builder(
        itemCount: textFields.length+1,
        itemBuilder: (context, index) => isFirstItem(index) ? getImageWidget() : fieldCard(textFields[index-1]),
      ),
      bottomNavigationBar: (isDescriptionScenario && !isEditScenario) ? SizedBox() : getButtonWidget(buttonTitle, saveMovie)
    );
  }

  Widget getImageWidget() {
    return Center(
      child: Stack(
        children: [
          isImageAvailable
            ? CircleAvatar(
                radius: Radiuses.IMAGE_AVATAR,
                backgroundColor: Colours.SECONDARY_BACKGROUND,
                backgroundImage: FileImage(imageFile),
              ).withOpacity(imageOpacity).withPad(Paddings.TOP_PADDING1)
            : CircleAvatar(
                radius: Radiuses.IMAGE_AVATAR,
                backgroundColor: Colours.SECONDARY_BACKGROUND,
              ).withPad(Paddings.TOP_PADDING1),
          isDescriptionScenario && !isEditScenario
            ? SizedBox()
            : CircleAvatar(
                radius: Radiuses.IMAGE_AVATAR,
                backgroundColor: Colors.transparent,
                child: Icon(
                  isEditScenario ? Icons.edit : Icons.add,
                  color: Colours.PRIMARY_TEXT,
                  size: SIZES.DEF_ICON_SIZE,
                ),
          ).withPad(Paddings.VERTICAL_PADDING1).onTap(() => showImageSelectionPopup())
        ],
      ),
    );
  }

  showImageSelectionPopup() {
    _showSelectionDialog(context, DisplayLabels.PICK_FROM, DisplayLabels.OPTIONS_GALLERY, () {_openGallery(context);} , DisplayLabels.OPTIONS_CAMERA, _showCamera);
  }

  showDeleteConfirmationDialog() {
    _showSelectionDialog(context, DisplayLabels.DELETE_CONFIRMATION, DisplayLabels.DELETE_CONFIRMATION_APPROVED, deleteMovie , DisplayLabels.DELETE_CONFIRMATION_DENIED, () => Get.back());
  }

  // Widget getImageIcon() {
  //   if(isDescriptionScenario && !isEditScenario) {
  //     if(isImageAvailable)
  //       return SizedBox();
  //     else
  //       return Icon(Icons.where);
  //   }
  //   // desccription screen (image -> none, question mark)
  //   //edit screen (edit)
  //   //add screen (add)
  // }

  Widget fieldCard(FieldCard fieldCard) {
    if(isDescriptionScenario && !isEditScenario && !fieldCard.forDescription)
      return SizedBox();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              fieldCard.fieldTitle,
              style: TextStyles.LIGHTSUBTITLE1,
            ).withPad(Paddings.HORIZONTAL_PADDING1),
            Text(
              DisplayLabels.REQUIRED_FIELD,
              style: TextStyles.REQUIREDFIELD,
            )
          ],
        ),
        Container(
          decoration: BoxDecoration(
            color: Colours.SECONDARY_BACKGROUND,
            borderRadius: BorderRadiuses.BORDER_RADIUS2
          ),
          child: TextField(
            controller: fieldCard.controller,
            inputFormatters: [
              LengthLimitingTextInputFormatter(fieldCard.lengthLimit)
            ],
            readOnly: (isDescriptionScenario && !isEditScenario) ? true : false,
            keyboardType: fieldCard.textInputType,
            cursorColor: Colours.PRIMARY_TEXT,
            style: TextStyles.LIGHTSUBTITLE1,
            decoration: InputDecoration(
              hintText: fieldCard.hintText,
              hintStyle: TextStyles.DARKSUBTITLE1,
              prefixIcon: fieldCard.prefixIcon,
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colours.PRIMARY_TEXT),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colours.PRIMARY_TEXT),
              ),
            ),
          ).withPad(Paddings.PADDING1),
        ).withPad(Paddings.PADDING3),
      ],
    ).withPad(Paddings.PADDING3);
  }

  Widget getLeadingWidget() {
    return isEditScenario
      ? Icon(
          Icons.cancel_outlined,
          size: SIZES.DEF_ICON_SIZE,
        ).withPad(Paddings.PADDING1).onTap(() => cancelEditing())
      : Icon(
          Icons.arrow_back,
          size: SIZES.DEF_ICON_SIZE,
        ).withPad(Paddings.PADDING1).onTap(() => Get.back());
  }

  Map<bool, String> validation() {
    bool isValidForm = true;
    String error = "";
    textFields.reversed.forEach(
      (element) => element.isMandatory && element.controller.text.length == 0 ? {isValidForm = false, error = element.errorMessage} : {}
    );
    if(!isImageAvailable) {
      isValidForm = false;
      error = "Please add an image";
    }
    return {isValidForm: error};
  }

  List<Widget> appBarActions() {
    if(isAddNewScenario)
      return [];
    return [
      Icon(
        isEditScenario ? Icons.delete_outline : Icons.edit,
        size: SIZES.DEF_ICON_SIZE,
        color: Colours.PRIMARY_TEXT,
      ).withPad(
        Paddings.HORIZONTAL_PADDING1
      ).onTap(
        () => isEditScenario ? showDeleteConfirmationDialog() : editMovie()
      ),
    ];
  }

  Future<void> _showSelectionDialog(BuildContext context, String title, String option1, Function implement1, String option2, Function implement2) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadiuses.BORDER_RADIUS1),
          contentPadding: Paddings.DIALOG_PADDING1,
          backgroundColor: Colours.SECONDARY_BACKGROUND,
          title: Text(
            title,
            style: TextStyles.PRIMARY_BUTTON,
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colours.PRIMARY_TEXT,
                    borderRadius: BorderRadiuses.BORDER_RADIUS3
                  ),
                  child: Center(
                    child: Text(
                      option1,
                      style: TextStyles.DARKSUBTITLE15,
                    ).withPad(Paddings.PADDING1),
                  ),
                ).onTap(
                  () => implement1()
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                Container(
                  decoration: BoxDecoration(
                    color: Colours.PRIMARY_TEXT,
                    borderRadius: BorderRadiuses.BORDER_RADIUS3
                  ),
                  child: Center(
                    child: Text(
                      option2,
                      style: TextStyles.DARKSUBTITLE15,
                    ).withPad(Paddings.PADDING1),
                  ),
                ).onTap(
                  () => implement2()
                ),
              ],
            ),
          )
        );
      }
    );
  }

  void _openGallery(BuildContext context) async {
    Get.back();
    var picture = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      imageFile = File(picture.path);
    });
  }

  void _showCamera() async {
    Get.back();
    takeImageFromCamera(imageSource: ImageSource.camera).then(
      (value) => setState(() {
        if (value != null) {
          imageFile = File(value);
        }
      })
    );
  }

  static Future<String> takeImageFromCamera({ImageSource imageSource}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: imageSource ?? ImageSource.camera);
    return pickedFile?.path;
  }

  editMovie() => setState(() => isEditingEnabled = true);

  cancelEditing() => setState(() => isEditingEnabled = false);

  deleteMovie() async {
    bool status = await _movieController.deleteMovieFromDatabase(widget.editMovie);
    if(status) {
      _movieController.fetchAllMovies(userId);
      Get.back();
      Get.back();
      Get.showSnackbar(Snackbars.successBar(DisplayLabels.MOVIE_DELETION_SUCCESS_MESSAGE));
    }
    else
      Get.showSnackbar(Snackbars.errorBar(DisplayLabels.MOVIE_DELETION_FAILURE_MESSAGE));
  }

  saveMovie() async {
    Map validationStatus = validation();
    if(validationStatus.keys.first) {
      Movie movie = Movie(
        movieTitle: textFields.first.controller.text,
        directorName: textFields.last.controller.text,
        userId: _userController.googleUser.id,
        movieId: movieId,
        posterPath: imageFile.path
      );
      bool isSaved = isEditScenario
        ? await _movieController.updateMovieInDatabase(movie)
        : await _movieController.addMovieToDatabase(movie);
      if(isSaved) {
        _movieController.fetchAllMovies(userId);
        Get.back();
        Get.showSnackbar(Snackbars.successBar(DisplayLabels.MOVIE_ADDITION_SUCCESS_MESSAGE));
      }else
        Get.showSnackbar(Snackbars.errorBar(DisplayLabels.MOVIE_ADDITION_FAILURE_MESSAGE));
    }else
      Get.showSnackbar(Snackbars.errorBar(validationStatus.values.first));
  }
  
}