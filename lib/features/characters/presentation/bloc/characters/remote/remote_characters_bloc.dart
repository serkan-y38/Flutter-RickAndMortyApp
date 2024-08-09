import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/domain/use_case/remote/get_characters_use_case.dart';

import '../../../../domain/entity/character_entity.dart';

class RemoteCharactersBloc extends Bloc<RemoteCharactersEvent, RemoteCharactersState> {
  final GetCharactersUseCase _getCharactersUseCase;
  final Set<int> _characterIds = {}; // Track unique character IDs

  RemoteCharactersBloc(this._getCharactersUseCase)
      : super(const RemoteCharactersLoading()) {
    on<GetCharacters>(onGetCharacters);
    on<LoadMoreCharacters>(onLoadMoreCharacters);
  }

  int pageNumber = 0;

  void onGetCharacters(GetCharacters event, Emitter<RemoteCharactersState> emitter) async {
    pageNumber = 0;
    _characterIds.clear();
    final dataState = await _getCharactersUseCase(params: pageNumber);
    if (dataState is Success<List<CharacterEntity>> && dataState.data!.isNotEmpty) {
      _updateCharactersState(dataState, emitter);
    } else if (dataState is Error) {
      emitter(RemoteCharactersError(dataState.dio!));
    } else if (dataState is Loading) {
      emitter(const RemoteCharactersLoading());
    }
  }

  void onLoadMoreCharacters(LoadMoreCharacters event, Emitter<RemoteCharactersState> emitter) async {
    pageNumber++;
    final dataState = await _getCharactersUseCase(params: pageNumber);
    if (dataState is Success<List<CharacterEntity>> && dataState.data!.isNotEmpty) {
      _updateCharactersState(dataState, emitter);
    } else if (dataState is Error) {
      emitter(RemoteCharactersError(dataState.dio!));
    }
  }

  void _updateCharactersState(Success<List<CharacterEntity>> dataState, Emitter<RemoteCharactersState> emitter) {
    final newCharacters = dataState.data!.where((character) => _characterIds.add(character.id!)).toList();
    if (newCharacters.isNotEmpty) {
      if (state is RemoteCharactersSuccess) {
        final currentList = (state as RemoteCharactersSuccess).characters!;
        final updatedList = List<CharacterEntity>.from(currentList)..addAll(newCharacters);
        emitter(RemoteCharactersSuccess(updatedList));
      } else {
        emitter(RemoteCharactersSuccess(newCharacters));
      }
    }
  }
}

