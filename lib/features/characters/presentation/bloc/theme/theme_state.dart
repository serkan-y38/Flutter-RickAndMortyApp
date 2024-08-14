import 'package:equatable/equatable.dart';
import 'package:rickandmorty/core/theme/theme.dart';

class ThemeState extends Equatable {
  final AppTheme theme;

  const ThemeState(this.theme);

  @override
  List<Object?> get props => [theme];
}

class GetThemeSuccess extends ThemeState {
  const GetThemeSuccess(super.theme);
}

class ThemeLoading extends ThemeState {
  const ThemeLoading() : super(AppTheme.systemSetting);
}
