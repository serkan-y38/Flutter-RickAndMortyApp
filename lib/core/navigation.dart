import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/presentation/screen/character_details_screen/character_details_screen.dart';
import 'package:rickandmorty/features/characters/presentation/screen/characters_screen/characters_screen.dart';

class RouteNavigation {
  static const String charactersScreen = "charactersScreen";
  static const String characterDetailsScreen = "characterDetailsScreen";
}

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNavigation.charactersScreen:
        return MaterialPageRoute(builder: (_) => const CharactersScreen());
      case RouteNavigation.characterDetailsScreen:
        return MaterialPageRoute(builder: (_) => CharacterDetailsScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
