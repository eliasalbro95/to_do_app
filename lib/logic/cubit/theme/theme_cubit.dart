import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState(themeMode: ThemeMode.light)) {
    updateAppTheme(false);
  }

  static ThemeCubit get(context) => BlocProvider.of(context);

  void updateAppTheme(bool sw) {
    // change with System mode
    // final Brightness currentBrightness = AppTheme.currentSystemBrightness;
    // currentBrightness == Brightness.light? _setTheme(ThemeMode.light):_setTheme(ThemeMode.dark);

    // change with switch
    sw ? _setTheme(ThemeMode.dark) : _setTheme(ThemeMode.light);
  }

  void _setTheme(ThemeMode themeMode) {
    emit(ThemeState(themeMode: themeMode));
  }
}
