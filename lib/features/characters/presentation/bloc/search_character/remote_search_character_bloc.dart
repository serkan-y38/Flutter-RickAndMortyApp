import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/domain/use_case/remote/search_character_use_case.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/search_character/remote_search_character_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/search_character/remote_search_character_state.dart';

import '../../../../../core/resource.dart';
import '../../../domain/entity/character_entity.dart';

class RemoteSearchCharacterBloc
    extends Bloc<RemoteSearchCharacterEvent, RemoteSearchCharacterState> {
  final SearchCharacterUseCase _searchCharacterUseCase;
  final Set<int> _characterIds = {};
  final List<CharacterEntity> _characters = [];

  RemoteSearchCharacterBloc(this._searchCharacterUseCase)
      : super(const RemoteSearchCharacterLoading()) {
    on<SearchCharacters>(onSearchCharacter);
    on<LoadMoreSearchCharacter>(onLoadMoreSearchCharacter);
  }

  int pageNumber = 0;

  void onSearchCharacter(SearchCharacters event,
      Emitter<RemoteSearchCharacterState> emitter) async {
    pageNumber = 0;
    _characterIds.clear();
    _characters.clear();
    final dataState =
        await _searchCharacterUseCase(params: (pageNumber, event.name));
    if (dataState is Success<List<CharacterEntity>> &&
        dataState.data!.isNotEmpty) {
      _updateCharactersState(dataState, emitter, isLoadMore: false);
    } else if (dataState is Error) {
      emitter(RemoteSearchCharacterError(dataState.dio!));
    } else if (dataState is Loading) {
      emitter(const RemoteSearchCharacterLoading());
    }
  }

  void onLoadMoreSearchCharacter(LoadMoreSearchCharacter event,
      Emitter<RemoteSearchCharacterState> emitter) async {
    pageNumber++;
    final dataState =
        await _searchCharacterUseCase(params: (pageNumber, event.name));
    if (dataState is Success<List<CharacterEntity>> &&
        dataState.data!.isNotEmpty) {
      _updateCharactersState(dataState, emitter, isLoadMore: true);
    } else if (dataState is Error) {
      emitter(RemoteSearchCharacterError(dataState.dio!));
    }
  }

  void _updateCharactersState(Success<List<CharacterEntity>> dataState,
      Emitter<RemoteSearchCharacterState> emitter,
      {required bool isLoadMore}) {
    final newCharacters = dataState.data!
        .where((character) => _characterIds.add(character.id!))
        .toList();
    if (newCharacters.isNotEmpty) {
      if (isLoadMore && state is RemoteSearchCharacterSuccess) {
        // Append new characters to the existing list
        _characters.addAll(newCharacters);
      } else {
        // Replace with new characters for a fresh load
        _characters.clear();
        _characters.addAll(newCharacters);
      }
      emitter(RemoteSearchCharacterSuccess(List.from(_characters)));
    }
  }
}
