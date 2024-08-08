import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entity/character_entity.dart';

abstract class RemoteSearchCharacterState extends Equatable {
  final List<CharacterEntity>? characters;
  final DioException? dioException;

  const RemoteSearchCharacterState({this.characters, this.dioException});

  @override
  List<Object?> get props => [characters, dioException];
}

class RemoteSearchCharacterLoading extends RemoteSearchCharacterState {
  const RemoteSearchCharacterLoading();
}

class RemoteSearchCharacterSuccess extends RemoteSearchCharacterState {
  const RemoteSearchCharacterSuccess(List<CharacterEntity> list)
      : super(characters: list);
}

class RemoteSearchCharacterError extends RemoteSearchCharacterState {
  const RemoteSearchCharacterError(DioException e) : super(dioException: e);
}
