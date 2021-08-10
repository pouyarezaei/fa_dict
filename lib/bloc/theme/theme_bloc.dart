import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fa_dict/ui/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_event.dart';

part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(ThemeMode themeMode) : super(ThemeInitial(themeMode));

  set state(ThemeState themeState) {
    state = themeState;
  }

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChanged) {
      switch (event.themeMode) {
        case ThemeMode.light:
          await _persistTheme(event.themeMode);
          yield ThemeLight();
          break;
        case ThemeMode.dark:
          await _persistTheme(event.themeMode);
          yield ThemeDark();
          break;
        case ThemeMode.system:
          await _persistTheme(event.themeMode);
          yield ThemeSystem();
          break;
      }
    }
  }

  _persistTheme(ThemeMode theme) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(AppTheme.themeKey, theme.index);
    print(
        "${AppTheme.themeKey} ${theme.index} ${ThemeMode.values[theme.index]}");
  }
}
