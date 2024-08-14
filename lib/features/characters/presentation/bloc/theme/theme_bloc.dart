import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/core/theme/theme.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/theme/theme_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/theme/theme_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferences _sharedPreferences;

  ThemeBloc(this._sharedPreferences) : super(const ThemeLoading()) {
    on<GetTheme>(onGetTheme);
    on<SetTheme>(onSetTheme);
  }

  Future<void> onSetTheme(SetTheme event, Emitter<ThemeState> emitter) async {
    await _sharedPreferences.setString(
        AppTheme.themeKey.name, event.theme!.name);
    emitter(GetThemeSuccess(event.theme!));
  }

  Future<void> onGetTheme(GetTheme event, Emitter<ThemeState> emitter) async {
    final state = _sharedPreferences.getString(AppTheme.themeKey.name);
    if (state != null) {
      if (state == AppTheme.dark.name) {
        emitter(const GetThemeSuccess(AppTheme.dark));
      } else if (state == AppTheme.light.name) {
        emitter(const GetThemeSuccess(AppTheme.light));
      } else {
        emitter(const GetThemeSuccess(AppTheme.systemSetting));
      }
    } else {
      emitter(const GetThemeSuccess(AppTheme.systemSetting));
    }
  }
}
