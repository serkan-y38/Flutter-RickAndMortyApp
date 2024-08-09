import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rickandmorty/features/characters/domain/use_case/local/delete_character_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/local/get_saved_characters_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/local/insert_character_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/local/is_character_saved_use_case.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/local/local_characters_event.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/local/local_characters_state.dart';

import '../../../../../../core/resource.dart';
import '../../../../domain/entity/character_entity.dart';

class LocalCharactersBloc
    extends Bloc<LocalCharactersEvent, LocalCharactersState> {
  final GetSavedCharactersUseCase _getSavedCharactersUseCase;
  final InsertCharacterUseCase _insertCharacterUseCase;
  final DeleteCharacterUseCase _deleteCharacterUseCase;
  final IsCharacterSavedUseCase _isCharacterSavedUseCase;

  LocalCharactersBloc(
      this._deleteCharacterUseCase,
      this._insertCharacterUseCase,
      this._getSavedCharactersUseCase,
      this._isCharacterSavedUseCase)
      : super(const LocalCharactersLoading()) {
    on<GetSavedCharacters>(onGetSavedCharacters);
    on<DeleteCharacter>(onDeleteCharacter);
    on<InsertCharacter>(onInsertCharacter);
    on<IsCharacterSaved>(onIsCharacterSaved);
  }

  void onGetSavedCharacters(
      GetSavedCharacters event, Emitter<LocalCharactersState> emitter) async {
    final dataState = await _getSavedCharactersUseCase();
    if (dataState is Success<List<CharacterEntity>> &&
        dataState.data!.isNotEmpty) {
      emitter(LocalCharactersSuccess(dataState.data!));
    } else if (dataState is Error) {
      emitter(LocalCharactersError(dataState.dio!));
    } else if (dataState is Loading) {
      emitter(const LocalCharactersLoading());
    }
  }

  void onDeleteCharacter(
      DeleteCharacter event, Emitter<LocalCharactersState> emitter) async {
    await _deleteCharacterUseCase(params: event.entity!);
    onGetSavedCharacters(const GetSavedCharacters(), emitter);
  }

  void onInsertCharacter(
      InsertCharacter event, Emitter<LocalCharactersState> emitter) async {
    await _insertCharacterUseCase(params: event.entity!);
    onGetSavedCharacters(const GetSavedCharacters(), emitter);
  }

  void onIsCharacterSaved(
      IsCharacterSaved event, Emitter<LocalCharactersState> emitter) async {
    bool? result = await _isCharacterSavedUseCase.call(params: event.id!);
    emitter(IsCharacterSavedResultSuccess(result));
  }
}
