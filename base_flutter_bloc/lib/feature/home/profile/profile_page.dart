import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:base_flutter_bloc/utils/utils.dart';
import 'package:flutter/cupertino.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.backgroundColor,
      alignment: Alignment.center,
      child: BaseWidget.buildLogo(AppStr.imgLogoEI, AppDimens.sizeImage),
    );
  }
}
