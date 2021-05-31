import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:flutter/cupertino.dart';

// bool isEmailInvalid(String email) => !isEmail(email);

bool isPasswordValidate({
  @required String password,
  @required int minLength,
  int maxLength = 0,
}) {
  if (password != null && password.isNotEmpty) {
    // Trường hợp có yêu cầu nhập tối đa vào mật khẩu.
    if (maxLength > 0) {
      if (password.length >= minLength && password.length <= maxLength) {
        return true;
      }
    } else {
      // Trường hợp chỉ yêu cầu số ký tự tối thiểu nhập vào của mật khẩu.
      if (password.length >= minLength) {
        return true;
      }
    }
  }
  return false;
}

bool isInvalidTextInput(String textInput, CheckValidation validation) {
  if (textInput != null && textInput.trim().isNotEmpty) {
    switch (validation) {
      case CheckValidation.PASSWORD:
        return textInput.length < 8 || textInput.length > 50;
        break;
      case CheckValidation.PHONE:
        return textInput.length != 10;
        break;
      default:
        return textInput.isEmpty;
    }
  }
  return true;
}

bool isStringNotEmpty(String s) => s != null && s.isNotEmpty;

bool isStringEmpty(String s) => s != null && s.isEmpty;

bool isListNotEmpty(List<dynamic> list) => list != null && list.isNotEmpty;
