import 'package:rickandmorty/core/use_case.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/domain/repository/characters_repository.dart';

class DeleteCharacterUseCase implements UseCase<void, CharacterEntity> {
  final CharactersRepository _charactersRepository;

  DeleteCharacterUseCase(this._charactersRepository);

  @override
  Future<void> call({required CharacterEntity params}) {
    return _charactersRepository.deleteCharacter(params);
  }
}
