import 'package:equatable/equatable.dart';
import 'package:rickandmorty/core/theme/theme.dart';

abstract class ThemeEvent extends Equatable {
  final AppTheme? theme;

  const ThemeEvent({this.theme});

  @override
  List<Object?> get props => [];
}

class SetTheme extends ThemeEvent {
  @override
  List<Object?> get props => [theme!];

  const SetTheme(AppTheme theme) : super(theme: theme);
}

class GetTheme extends ThemeEvent {
  const GetTheme() : super();
}
