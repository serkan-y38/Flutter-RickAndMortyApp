import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/domain/entity/episode_entity.dart';

abstract class CharactersRepository {
  /// Remote

  Future<Resource<List<CharacterEntity>>> getCharacters(int? page);

  Future<Resource<List<CharacterEntity>>> searchCharacter(
      int? page, String? name);

  Future<Resource<List<CharacterEntity>>> getCharactersWithIds(String idList);

  Future<Resource<EpisodeEntity>> getEpisode(String? id);

  /// Local

  Future<Resource<List<CharacterEntity>>> getSavedCharacters();

  Future<void> insertCharacter(CharacterEntity entity);

  Future<void> deleteCharacter(CharacterEntity entity);

  Future<bool?> isCharacterSaved(int id);
}
