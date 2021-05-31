class AppConst {
  //url

  static const String urlBase = ' https://github.com/sangtuty102/';

  static const String urlRepoBaseBloc =
      '$urlBase/sangtuty102/base_flutter_bloc.git';
  static const String urlRepoBaseGetX = '$urlBase/sangtuty102/base_getX.git';
  static const String urlNotify = '$urlBase/sangtuty102/notify';

  //base
  static const int pageSize = 10;
  static const int defaultPage = 1;
  static const int requestTimeOut = 15000; //ms

  static const int millisecondsDefault = 1000;

// sharedPref
  static const String keyUserId = 'key_user_id';
  static const String keyUserName = 'key_user_name';
  static const String keyPassword = 'key_password';
  static const String keyTokenDevice = "key_token_device";
  static const String keyTokenAcount = "key_token_account";
  static const String keyTheme = 'key_theme';
  static const String keyPattern = 'key_pattern';
  static const String keySerial = 'key_serial';
  static const String keyStatus = 'key_status';
  static const String keyTime = 'key_time';
  static const String keyFromDate = 'key_from_date';
  static const String keyToDate = 'key_to_date';
  static const String keyPathInvoice = 'key_path_invoice';
  static const String keySendEmail = 'key_send_email';

// routes enum: các đường dẫn chuyển màn trong app
  static const String routeHome = '/home';
  static const String routeLogin = '/login';
  static const String routeSplash = '/splash';
  static const String routeProfile = '/Profile';
  static const String routeNotifycation = '/Notifycation';

  //error
  static const int error500 = 500;
  static const int error404 = 404;
  static const int error401 = 401;
  static const int error400 = 400;
  static const int error502 = 502;
  static const int error503 = 503;
}

enum CheckValidation { PHONE, PASSWORD }
