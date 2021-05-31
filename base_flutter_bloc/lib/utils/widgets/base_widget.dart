import 'dart:io' show Platform;

import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BaseWidget {
  static Widget buildLogo(String imgLogo, double height) {
    return SizedBox(
      height: height,
      child: Image.asset(imgLogo),
    );
  }

  static Widget buildLoading() {
    return Text("widget Loading ...");
  }

  static buildAppBarTitle(String title, {bool textAlignCenter}) {
    textAlignCenter = textAlignCenter ?? Platform.isAndroid;
    return Text(
      title,
      textAlign: textAlignCenter ? TextAlign.center : TextAlign.left,
      // style: AppStyle.textTitleWhiteStyle,
      textScaleFactor: 1,
    );
  }

  static Widget buidTitle(String title) {
    return Text(
      title,
      textScaleFactor: 1,
      // style:
      //     AppStyle.textTitleWhiteStyle.copyWith(color: AppColors.hintTextColor),
      textAlign: TextAlign.center,
    );
  }

  static Widget buildButton(String btnTitle, Function function, {Color color}) {
    return Container(
        width: double.infinity,
        height: AppDimens.btnMedium,
        child: ElevatedButton(
          onPressed: function,
          style: ElevatedButton.styleFrom(
            primary: color ?? AppColors.buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
          ),
          child: Text(btnTitle,
              style: TextStyle(
                  fontSize: AppDimens.fontMedium, color: Colors.white)),
        ));
  }

  static Widget simpleDivider() {
    return Divider(
      height: 0.0,
    );
  }

  

  
}
