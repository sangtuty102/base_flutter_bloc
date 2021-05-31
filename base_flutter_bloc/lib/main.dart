import 'package:base_flutter_bloc/base/view/base_theme.dart';
import 'package:base_flutter_bloc/const/all_const.dart';
import 'package:base_flutter_bloc/feature/home/notifycation/notify_page.dart';
import 'package:base_flutter_bloc/feature/home/profile/profile_page.dart';
import 'package:base_flutter_bloc/feature/login/login_page.dart';
import 'package:base_flutter_bloc/feature/splash/splash_page.dart';
import 'package:base_flutter_bloc/utils/keyboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';

import 'app_bloc/app_bloc.dart';
import 'feature/home/home_page.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  AppBloc appBloc = AppBloc();
  bool darkMode = false;

  @override
  void initState() {
    // Không cho xoay màn hình
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // set mauf cho stausBar ( Thanh bên trên hiên thị thời gian)
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.darkAccentColor,
      statusBarColor: AppColors.bgInputTextColor,
    ));
    super.initState();
  }

  @override
  void dispose() {
    // hủy HIVE khi tắt app
    Hive.close();
    super.dispose();
  }

  /// Application
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AppBloc>(
      create: (context) => appBloc..add(AppInit()),
      child: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state is AppDarkMode) {
            darkMode = state.isDarkMode;
          }
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: KeyBoard.hide,
            child: MaterialApp(
              navigatorKey: navigatorKey,
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate
              ],
              supportedLocales: [const Locale('vi')],
              theme: BlocProvider.of<AppBloc>(context).currentTheme,
              darkTheme: getThemeDataByAppTheme(AppThemeDark),
              builder: (context, child) {
                ErrorWidget.builder = (FlutterErrorDetails errorDetails) =>
                    _buildError(); // lỗi widget thì hiên thị để tránh người ta bt sử dụng flutter
                return ScrollConfiguration(
                  // tắt hiệu ứng khi vuốt keeos lên kéo xuống
                  behavior: MyBehavior(),
                  child: child,
                );
              },

              debugShowCheckedModeBanner: false,
              title: AppStr.appName,
              home: state is AppInitial
                  ? SplashPage()
                  : Scaffold(
                      body: state is AppCreated ? HomePage() : LoginPage()),

              initialRoute: AppConst.routeSplash,
              // routes: routes,
              onGenerateRoute: (settings) => _onGenerateRoute(settings),
            ),
          );
        },
      ),
    );
  }

  Route<dynamic> _onGenerateRoute(RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (_, __, ___) => _getWidgetByRoute(settings.name),
      transitionsBuilder: (_, Animation<double> animation,
          Animation<double> second, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: FadeTransition(
            opacity: Tween<double>(begin: 1.0, end: 0.0).animate(second),
            child: child,
          ),
        );
      },
    );
  }

  Widget _getWidgetByRoute(String routeName) {
    switch (routeName) {
      case AppConst.routeHome:
        return HomePage();
      case AppConst.routeLogin:
        return LoginPage();
      case AppConst.routeNotifycation:
        return NotifyPage();
      case AppConst.routeProfile:
        return ProfilePage();
    }
    return null;
  }
}

Widget _buildError() {
  return SafeArea(
    child: Scaffold(
        body: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset(
            AppStr.imgError,
            fit: BoxFit.cover,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 60.0),
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(35),
              child: Text("Lỗi hiển thị")),
        ),
      ],
    )),
  );
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
