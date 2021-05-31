import 'package:base_flutter_bloc/app_bloc/app_bloc.dart';
import 'package:flutter/cupertino.dart';

class KeyBoard {
  static void hide() {
    FocusScope.of(contextApp).requestFocus(FocusNode());
  }

  static bool keyboardIsVisible(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom != 0.0;
  }
}
