import '../../../../../core/resource.dart';
import '../../entity/character_entity.dart';
import '../../repository/characters_repository.dart';

class GetSavedCharactersUseCase {
  final CharactersRepository _charactersRepository;

  GetSavedCharactersUseCase(this._charactersRepository);

  Future<Resource<List<CharacterEntity>>> call() {
    return _charactersRepository.getSavedCharacters();
  }
}
