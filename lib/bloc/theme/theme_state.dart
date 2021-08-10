part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  late final ThemeMode themeMode;

  bool isDark() => this.themeMode == ThemeMode.dark;
}

class ThemeDark extends ThemeState {
  @override
  ThemeMode get themeMode => ThemeMode.dark;
}

class ThemeLight extends ThemeState {
  @override
  ThemeMode get themeMode => ThemeMode.light;
}

class ThemeSystem extends ThemeState {
  @override
  ThemeMode get themeMode => ThemeMode.system;
}

class ThemeInitial extends ThemeState {
  ThemeInitial(ThemeMode themeMode) {
    this.themeMode = themeMode;
  }
}
