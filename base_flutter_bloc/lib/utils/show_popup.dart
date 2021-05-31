import 'package:base_flutter_bloc/app_bloc/app_bloc.dart';
import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:base_flutter_bloc/utils/widgets/base_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowPopup {
  factory ShowPopup() {
    _instance.context = contextApp;
    return _instance;
  }

  /// required
  BuildContext context;

  /// local vars
  int numberOfDialogs = 0;

  static final _instance = ShowPopup._internal();

  ShowPopup._internal();

  void _showDialog(Widget dialog, bool isActiveBack) {
    assert(context != null, "Context must be not null");

    if (context != null) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () => onBackPress(isActiveBack),
              child: dialog,
            );
          }).then((value) => numberOfDialogs--);
      numberOfDialogs++;
    }
  }

  Future<bool> onBackPress(bool isActiveBack) {
    return Future.value(isActiveBack);
  }

  void dismissDialog({bool isAutoCloseDialog = false}) {
    if (!isAutoCloseDialog && numberOfDialogs > 0) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  /// Hiển thị loading
  ///
  /// `isActiveBack` có cho phép back từ bàn phím Android khi loading hay không, default = true
  void showLoadingWave({bool isActiveBack = true}) {
    _showDialog(getLoadingWidget(), isActiveBack);
  }

  Widget getLoadingWidget() {
    return Center(
      child: BaseWidget.buildLoading(),
    );
  }

  /// Hiển thị dialog thông báo với nội dung cần hiển thị
  ///
  /// `funtion` hành động khi bấm đóng
  ///
  /// `isActiveBack` có cho phép back từ bàn phím Android hay không, default = true
  ///
  /// `isChangeContext` default true: khi gọi func không close dialog hiện tại (khi chuyển sang màn mới thì dialog hiện tại sẽ tự đóng)
  void showDialogNotification(
    String content, {
    bool isActiveBack = true,
    Function function,
    bool isChangeContext = false,
    String nameAction,
  }) {
    _showDialog(
        Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 15, bottom: 10),
                  child: Icon(
                    _buildIconDialog(content),
                    size: AppDimens.sizeDialogNotiIcon,
                    color: Colors.blueAccent,
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  constraints: BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      style: TextStyle(fontSize: AppDimens.fontMedium),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      textScaleFactor: 1,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      dismissDialog(isAutoCloseDialog: isChangeContext);
                      if (function != null) {
                        function();
                      }
                    },
                    // highlightColor: Colors.transparent,
                    // splashColor: Colors.transparent,
                    child: Text(
                      nameAction ?? AppStr.close,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                      textScaleFactor: 1,
                      maxLines: 1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        isActiveBack);
  }

  IconData _buildIconDialog(String errorStr) {
    IconData iconData;
    switch (errorStr) {
      case AppStr.errorConnectTimeOut:
        iconData = Icons.alarm_off;
        break;
      case AppStr.error400:
      case AppStr.error401:
      case AppStr.error404:
      case AppStr.error502:
      case AppStr.error503:
      case AppStr.errorInternalServer:
        iconData = Icons.warning;
        break;
      case AppStr.errorConnectFailedStr:
        iconData = Icons.signal_wifi_off;
        break;
      default:
        iconData = Icons.notifications_none;
    }
    return iconData;
  }

  void showDialogConfirm(String content,
      {bool isActiveBack = true,
      Function confirm,
      String title,
      String actionTitle,
      bool isAutoCloseDialog = false}) {
    _showDialog(
        Dialog(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 15.0),
                  child: Text(
                    title ?? AppStr.notify,
                    textScaleFactor: 1,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: AppDimens.fontBiggest,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15.0),
                  constraints: BoxConstraints(maxHeight: 200),
                  child: SingleChildScrollView(
                    child: Text(
                      content,
                      style: TextStyle(fontSize: AppDimens.fontMedium),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                      textScaleFactor: 1,
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  width: double.infinity,
                  height: AppDimens.btnMedium,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextButton(
                          onPressed: dismissDialog,
                          child: Text(
                            AppStr.cancel,
                            textScaleFactor: 1,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: AppDimens.fontBig),
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: 1,
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            dismissDialog(isAutoCloseDialog: isAutoCloseDialog);
                            if (confirm != null) {
                              confirm();
                            }
                          },
                          child: Text(
                            actionTitle,
                            textScaleFactor: 1,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: AppDimens.fontBig,
                              color: Colors.redAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        isActiveBack);
  }
}
