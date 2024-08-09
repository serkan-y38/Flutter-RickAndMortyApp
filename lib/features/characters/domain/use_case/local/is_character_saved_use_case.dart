import 'package:rickandmorty/core/use_case.dart';
import 'package:rickandmorty/features/characters/domain/repository/characters_repository.dart';

class IsCharacterSavedUseCase implements UseCase<bool?, int> {
  final CharactersRepository _charactersRepository;

  IsCharacterSavedUseCase(this._charactersRepository);

  @override
  Future<bool?> call({required int params}) {
    return _charactersRepository.isCharacterSaved(params);
  }
}
