import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/core/use_case.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/domain/repository/characters_repository.dart';

class SearchCharacterUseCase
    implements
        UseCase<Resource<List<CharacterEntity>>, (int? page, String? name)> {
  final CharactersRepository _charactersRepository;

  SearchCharacterUseCase(this._charactersRepository);

  @override
  Future<Resource<List<CharacterEntity>>> call(
      {required (int?, String?) params}) {
    return _charactersRepository.searchCharacter(params.$1, params.$2);
  }
}
