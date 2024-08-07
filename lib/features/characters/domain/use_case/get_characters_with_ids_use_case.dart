import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/core/use_case.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/domain/repository/characters_repository.dart';

class GetCharactersWithIdsUseCase
    implements UseCase<Resource<List<CharacterEntity>>, String?> {
  final CharactersRepository _charactersRepository;

  GetCharactersWithIdsUseCase(this._charactersRepository);

  @override
  Future<Resource<List<CharacterEntity>>> call({required String? params}) {
    return _charactersRepository.getCharactersWithIds(params!);
  }
}
