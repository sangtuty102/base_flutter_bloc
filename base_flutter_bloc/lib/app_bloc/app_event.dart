part of 'app_bloc.dart';

@immutable
abstract class AppEvent extends Equatable {
  @override
  List<Object> get props => null;
}

class AppInit extends AppEvent {}

class ChangeTheme extends AppEvent {
  final int appTheme;
  ChangeTheme({this.appTheme = AppThemeDark});
}

class Error extends AppEvent {}
