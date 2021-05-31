import 'package:base_flutter_bloc/app_bloc/app_bloc.dart';
import 'package:base_flutter_bloc/base/bloc/base_bloc.dart';
import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:base_flutter_bloc/utils/keyboard.dart';
import 'package:base_flutter_bloc/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseStatefulWidgetState<SF extends StatefulWidget,
    B extends BaseBloc> extends State<SF> {
  bool isShowLoading = false;

  bool isKeyBoardShow = false;

  /// `Bloc` tuong ung voi tung man hinh
  B bloc;

  AppBloc appBloc;

  String checkSendEmail = HIVE_APP.get(AppConst.keySendEmail) ?? '';

  void initBloc();

  Widget buildWidgets(BuildContext context);

  @override
  void initState() {
    // handleInitState();

    initBloc();
    bloc?.setOnErrorListener(showErrorPopup);

    super.initState();
  }

  // void handleInitState() {
  //   if (appBloc == null) appBloc = BlocProvider.of<AppBloc>(context);

  //   /// Callback khi bloc call `onError()`
  //   appBloc.setOnErrorListener(showErrorPopup);
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    isKeyBoardShow = KeyBoard.keyboardIsVisible(context);
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   dynamicLinks();
    // });
    return buildWidgets(context);
  }

  bool isLoginSuccess() {
    return HIVE_APP.get(AppConst.keyTokenAcount)?.isNotEmpty ?? false;
  }

  void setShowLoading(bool isLoad) {
    if (mounted) {
      isShowLoading = isLoad;
    }
  }

  void showErrorPopup(Object error, StackTrace stacktrace) {
    // ẩn loading
    setState(() {
      setShowLoading(false);
    });
    // show dialog với thông báo lỗi

    showPopup.showDialogNotification(error.toString());
  }

  Widget baseShowLoading(Widget child) => Stack(
        children: <Widget>[
          IgnorePointer(
            ignoring: isShowLoading,
            child: child,
          ),
          Visibility(
              visible: isShowLoading,
              child: Container(
                color: Colors.black54,
                height: double.infinity,
                width: double.infinity,
                child: Text("Widget Loading"),
              )),
        ],
      );

  // void dynamicLinks() async {
  //   FirebaseDynamicLinks.instance.onLink(
  //       onSuccess: (PendingDynamicLinkData dynamicLink) async {
  //     sendEmail(dynamicLink);
  //   }, onError: (OnLinkErrorException e) async {
  //     print('onLinkError');
  //     print(e.message);
  //   });
  // }

  // void sendEmail(PendingDynamicLinkData data) async {
  //   final Uri deepLink = data?.link;
  //   if (deepLink != null &&
  //       HIVE_APP.get(AppConst.keySendEmail, defaultValue: '') !=
  //           deepLink.queryParameters.toString()) {
  //     HIVE_APP.put(AppConst.keySendEmail, deepLink.queryParameters.toString());
  //     var response = await Dio().get(
  //       deepLink.origin + deepLink.path,
  //       queryParameters: deepLink.queryParameters,
  //     );

  //     response != null
  //         ? showPopup.showDialogNotification(response.data, function: () {
  //             if (!isLoginSuccess()) {
  //               if (ModalRoute.of(context).settings.name != '/') {
  //                 Navigator.maybePop(context);
  //               }
  //               Navigator.pushNamed(context, AppConst.routeLogin);
  //             }
  //           })
  //         : Future.error(response);
  //   }
  // }
}
