import 'package:flutter/material.dart';

class FieldCard {
  final String fieldTitle;
  final String hintText;
  final TextEditingController controller;
  final Widget prefixIcon;
  final int lengthLimit;
  final TextInputType textInputType;
  final bool isMandatory;
  final String errorMessage;
  final bool forDescription;

  FieldCard(this.fieldTitle, this.hintText, this.controller, this.prefixIcon, {this.lengthLimit = 50, this.textInputType = TextInputType.name, this.isMandatory = false, this.errorMessage = "", this.forDescription = true});
}