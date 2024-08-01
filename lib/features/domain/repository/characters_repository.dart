import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/features/domain/entity/character_entity.dart';

abstract class CharactersRepository {
  Future<Resource<List<CharacterEntity>>> getCharacters();
}
