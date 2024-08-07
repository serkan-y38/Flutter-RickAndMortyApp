import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domain/entity/character_entity.dart';

abstract class RemoteCharactersWithIdsState extends Equatable {
  final List<CharacterEntity>? characters;
  final DioException? dioException;

  const RemoteCharactersWithIdsState({this.characters, this.dioException});

  @override
  List<Object?> get props => [characters, dioException];
}

class RemoteCharactersWithIdsLoading extends RemoteCharactersWithIdsState {
  const RemoteCharactersWithIdsLoading();
}

class RemoteCharactersWithIdsError extends RemoteCharactersWithIdsState {
  const RemoteCharactersWithIdsError(DioException e) : super(dioException: e);
}

class RemoteCharactersWithIdsSuccess extends RemoteCharactersWithIdsState {
  const RemoteCharactersWithIdsSuccess(List<CharacterEntity> e)
      : super(characters: e);
}
