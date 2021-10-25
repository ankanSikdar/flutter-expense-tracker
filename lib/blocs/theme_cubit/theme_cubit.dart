import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  final SharedPreferences _preferences;

  ThemeCubit({@required SharedPreferences preferences})
      : _preferences = preferences,
        super(ThemeState.initial()) {
    loadThemeIfPresent();
  }

  void toRed() {
    emit(
      state.copyWith(
        color: ThemeColor.red,
        theme: redTheme,
      ),
    );
    saveTheme(ThemeColor.red);
  }

  void toPurple() {
    emit(
      state.copyWith(
        color: ThemeColor.purple,
        theme: purpleTheme,
      ),
    );
    saveTheme(ThemeColor.purple);
  }

  void toBlue() {
    emit(
      state.copyWith(
        color: ThemeColor.blue,
        theme: blueTheme,
      ),
    );
    saveTheme(ThemeColor.blue);
  }

  void toGreen() {
    emit(
      state.copyWith(
        color: ThemeColor.green,
        theme: greenTheme,
      ),
    );
    saveTheme(ThemeColor.green);
  }

  void loadThemeIfPresent() {
    final savedTheme = _preferences.getString('theme');
    if (savedTheme != null) {
      ThemeColor color = ThemeColor.values
          .firstWhere((element) => element.toString() == savedTheme);
      switch (color) {
        case ThemeColor.blue:
          toBlue();
          break;
        case ThemeColor.purple:
          toPurple();
          break;
        case ThemeColor.green:
          toGreen();
          break;
        case ThemeColor.red:
          toRed();
      }
    }
  }

  void saveTheme(ThemeColor color) {
    _preferences.setString(
      'theme',
      color.toString(),
    );
  }
}
