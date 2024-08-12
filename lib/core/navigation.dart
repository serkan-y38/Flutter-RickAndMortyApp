import 'package:flutter/material.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/presentation/screen/character_details_screen/character_details_screen.dart';
import 'package:rickandmorty/features/characters/presentation/screen/characters_screen/characters_screen.dart';
import 'package:rickandmorty/features/characters/presentation/screen/episode_screen/episode_screen.dart';
import 'package:rickandmorty/features/characters/presentation/screen/saved_characters_screen/saved_characters_screen.dart';

class RouteNavigation {
  static const String charactersScreen = "charactersScreen";
  static const String characterDetailsScreen = "characterDetailsScreen";
  static const String episodeScreen = "episodeScreen";
  static const String savedCharactersScreen = "savedCharactersScreen";
}

class RouterClass {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNavigation.charactersScreen:
        return MaterialPageRoute(builder: (_) => const CharactersScreen());
      case RouteNavigation.characterDetailsScreen:
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(
                characterEntity: settings.arguments as CharacterEntity));
      case RouteNavigation.episodeScreen:
        return MaterialPageRoute(
            builder: (_) =>
                EpisodeScreen(episodeId: settings.arguments as String));
      case RouteNavigation.savedCharactersScreen:
        return MaterialPageRoute(builder: (_) => const SavedCharactersScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
