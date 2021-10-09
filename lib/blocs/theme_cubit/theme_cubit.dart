import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  void toRed() {
    emit(
      state.copyWith(
        color: ThemeColor.red,
        theme: redTheme,
      ),
    );
  }

  void toPurple() {
    emit(
      state.copyWith(
        color: ThemeColor.purple,
        theme: purpleTheme,
      ),
    );
  }

  void toBlue() {
    emit(
      state.copyWith(
        color: ThemeColor.blue,
        theme: blueTheme,
      ),
    );
  }
}
