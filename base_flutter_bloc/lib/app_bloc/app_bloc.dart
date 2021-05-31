import 'dart:async';

import 'package:base_flutter_bloc/base/base.dart';
import 'package:base_flutter_bloc/base/bloc/base_bloc.dart';
import 'package:base_flutter_bloc/base/locator/get_it.dart';
import 'package:base_flutter_bloc/base/view/base_theme.dart';
import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:base_flutter_bloc/feature/home/notifycation/repository/notify_repository.dart';
import 'package:base_flutter_bloc/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

part 'app_event.dart';
part 'app_state.dart';

var HIVE_APP;

/// dùng để lưu dữ liệu (`Ghi`: .put(k,v), `Đọc` : .get(k))

final navigatorKey = GlobalKey<
    NavigatorState>(); // biến để xác định context, giải quyết bài toán ShowPopUp(context)

ShowPopup showPopup = ShowPopup();
final contextApp = navigatorKey.currentState.overlay.context;

class AppBloc extends BaseBloc<AppEvent, AppState> {
  AppBloc() : super(AppInitial());

  final GetIt _getIt =
      GetIt.I; // dùng để khởi tạo, lưu Instan các class cần dùng trong toàn APP

  ThemeData currentTheme = getThemeDataByAppTheme(AppDefaultTheme);
  @override
  void onError(Object error, StackTrace stacktrace) {
    // Khi load articles ở màn splash lỗi -> home page
    this.add(Error());
    super.onError(error, stacktrace);
  }

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is AppInit) {
      yield* appInit();
    } else if (event is ChangeTheme) {
      yield* changeTheme(event);
    } else if (event is Error) {
      yield AppCreated();
    }
  }

  Stream<AppState> changeTheme(ChangeTheme event) async* {
    currentTheme = getThemeDataByAppTheme(event.appTheme ?? AppDefaultTheme);
    HIVE_APP.put(AppConst.keyTheme, event.appTheme);

    AppState currentState = state;
    yield AppInitial();
    yield currentState;
  }

  Stream<AppState> appInit() async* {
    initHive();

    /// initial
    _getIt.registerSingleton(BaseRequest());

// Nên khởi tạo Các Class_Repository() ở đầy
    _getIt.registerSingleton(LoginRepository());
    _getIt.registerSingleton(LoginRepository()); //vd1
    _getIt.registerSingleton(LoginRepository()); //vd2

    // get default theme

    int lastTheme = HIVE_APP.get(AppConst.keyTheme) ?? AppDefaultTheme;
    yield* changeTheme(ChangeTheme(appTheme: lastTheme));
    await Future.delayed(Duration(milliseconds: 800));

    yield AppCreated();
  }
}

void initHive() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lấy Path để tạo nopiw lưu của HIVE
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

// Khởi tạo HIVE
  HIVE_APP = await Hive.openBox(AppStr.appName);
}
