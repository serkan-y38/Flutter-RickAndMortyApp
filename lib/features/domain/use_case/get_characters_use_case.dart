import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/core/use_case.dart';
import 'package:rickandmorty/features/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/domain/repository/characters_repository.dart';

class GetCharactersUseCase implements UseCase<Resource<List<CharacterEntity>>, void> {

  final CharactersRepository _charactersRepository;

  GetCharactersUseCase(this._charactersRepository);

  @override
  Future<Resource<List<CharacterEntity>>> call({params}) {
    return _charactersRepository.getCharacters();
  }
}
