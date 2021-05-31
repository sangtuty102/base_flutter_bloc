import 'package:base_flutter_bloc/app_bloc/app_bloc.dart';
import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:flutter/material.dart';

Widget itemLine(
    {@required String title,
    Widget leading,
    String subtitle = '',
    Widget trailing = const Icon(Icons.keyboard_arrow_right),
    Function func}) {
  return subtitle.isEmpty
      ? SizedBox(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Theme.of(contextApp).cardColor),
            child: ListTile(
              onTap: func,
              leading: leading,
              title: Text(
                title,
              ),
              trailing: trailing,
            ),
          ),
        )
      : SizedBox(
          child: DecoratedBox(
            decoration: BoxDecoration(color: Theme.of(contextApp).cardColor),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                  vertical: AppDimens.paddingVerySmall,
                  horizontal: AppDimens.defaultPadding),
              onTap: func,
              leading: leading,
              title: Text(
                title,
              ),
              subtitle: Text(
                subtitle,
                style: TextStyle(color: Colors.grey),
              ),
              trailing: trailing,
            ),
          ),
        );
}

Widget buildDivider({double height = 1.0}) {
  return Container(
    color: Theme.of(contextApp).cardColor,
    height: 1,
    width: MediaQuery.of(contextApp).size.width,
    child: Divider(
      thickness: height,
      // color: Theme.of(context).scaffoldBackgroundColor,
      indent: 20,
      endIndent: 20,
    ),
  );
}
