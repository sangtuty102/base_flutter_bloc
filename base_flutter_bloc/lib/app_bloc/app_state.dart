part of 'app_bloc.dart';

@immutable
abstract class AppState extends Equatable {
  @override
  List<Object> get props => null;
}

class AppInitial extends AppState {}

class AppCreated extends AppState {}

class AppDarkMode extends AppState {
  final bool isDarkMode;

  AppDarkMode(this.isDarkMode);
}
