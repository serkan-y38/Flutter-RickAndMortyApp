import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/character_entity.dart';

abstract class LocalCharactersState extends Equatable {
  final List<CharacterEntity>? characters;
  final DioException? dioException;
  final bool? result;

  const LocalCharactersState({this.characters, this.dioException, this.result});

  @override
  List<Object?> get props => [characters, dioException, result];
}

class LocalCharactersLoading extends LocalCharactersState {
  const LocalCharactersLoading();
}

class LocalCharactersSuccess extends LocalCharactersState {
  const LocalCharactersSuccess(List<CharacterEntity> list)
      : super(characters: list);
}

class LocalCharactersError extends LocalCharactersState {
  const LocalCharactersError(DioException e) : super(dioException: e);
}

class IsCharacterSavedResultSuccess extends LocalCharactersState {
  const IsCharacterSavedResultSuccess(bool? result) : super(result: result);
}
