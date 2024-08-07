import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/core/use_case.dart';
import 'package:rickandmorty/features/characters/domain/entity/episode_entity.dart';
import 'package:rickandmorty/features/characters/domain/repository/characters_repository.dart';

class GetEpisodeUseCase implements UseCase<Resource<EpisodeEntity>, String?> {
  final CharactersRepository _charactersRepository;

  GetEpisodeUseCase(this._charactersRepository);

  @override
  Future<Resource<EpisodeEntity>> call({required String? params}) {
    return _charactersRepository.getEpisode(params);
  }
}
