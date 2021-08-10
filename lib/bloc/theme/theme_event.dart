part of 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {
  final ThemeMode themeMode;

  ThemeEvent({required this.themeMode});
}

class ThemeChanged extends ThemeEvent {
  ThemeChanged(themeMode) : super(themeMode: themeMode);
}
