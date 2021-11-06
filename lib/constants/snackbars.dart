import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poc_yellowc/constants/colours.dart';
import 'package:poc_yellowc/constants/styles.dart';

class Snackbars {

  static Widget successBar(String message) {
    return GetBar(
      margin: EdgeInsets.all(16),
      backgroundColor: Colours.SUCCESS_MESSAGE_SNACKBAR,
      borderRadius: 8,
      messageText: Container(
        child: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              child: Icon(
                Icons.done,
                color: Colours.PRIMARY_BACKGROUND,
                size: 12,
              ),
              decoration: BoxDecoration(
                border: Border.all(color: Colours.PRIMARY_BACKGROUND),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyles.LIGHTSUBTITLE1,
              ),
            ),
          ],
        ),
      ),
      duration: Duration(seconds: 3),
      animationDuration: Duration(milliseconds: 200),
    );
  }

  static Widget errorBar(String message) {
    return GetBar(
      margin: EdgeInsets.all(16),
      backgroundColor: Colours.REQUIRED,
      borderRadius: 8,
      messageText: Text(
        message,
        style: TextStyles.LIGHTSUBTITLE1,
      ),
      duration: Duration(seconds: 3),
      animationDuration: Duration(milliseconds: 200),
    );
  }
  
}