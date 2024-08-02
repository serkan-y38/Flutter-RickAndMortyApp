import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/core/use_case.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/domain/repository/characters_repository.dart';

class GetCharactersUseCase
    implements UseCase<Resource<List<CharacterEntity>>, int?> {
  final CharactersRepository _charactersRepository;

  GetCharactersUseCase(this._charactersRepository);

  @override
  Future<Resource<List<CharacterEntity>>> call({required int? params}) {
    return _charactersRepository.getCharacters(params);
  }
}
