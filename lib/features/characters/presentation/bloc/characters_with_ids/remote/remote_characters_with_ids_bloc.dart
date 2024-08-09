import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/domain/use_case/remote/get_characters_with_ids_use_case.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_with_ids/remote/remote_characters_with_ids_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_with_ids/remote/remote_characters_with_ids_state.dart';
import '../../../../../../core/resource.dart';
import '../../../../domain/entity/character_entity.dart';

class RemoteCharactersWithIdsBloc
    extends Bloc<RemoteCharactersWithIdsEvent, RemoteCharactersWithIdsState> {
  final GetCharactersWithIdsUseCase _getCharactersWithIdsUseCase;

  RemoteCharactersWithIdsBloc(this._getCharactersWithIdsUseCase)
      : super(const RemoteCharactersWithIdsLoading()) {
    on<GetCharactersWithIds>(onGetCharactersWithIdList);
  }

  void onGetCharactersWithIdList(GetCharactersWithIds event,
      Emitter<RemoteCharactersWithIdsState> emitter) async {
    final dataState = await _getCharactersWithIdsUseCase(params: event.idList);
    if (dataState is Success<List<CharacterEntity>>) {
      emitter(RemoteCharactersWithIdsSuccess(dataState.data!));
    } else if (dataState is Error) {
      emitter(RemoteCharactersWithIdsError(dataState.dio!));
    } else if (dataState is Loading) {
      emitter(const RemoteCharactersWithIdsLoading());
    }
  }
}
