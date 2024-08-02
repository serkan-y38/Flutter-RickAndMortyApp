import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';

abstract class RemoteCharactersState extends Equatable {
  final List<CharacterEntity>? characters;
  final DioException? dioException;

  const RemoteCharactersState({this.characters, this.dioException});

  @override
  List<Object?> get props => [characters, dioException];
}

class RemoteCharactersLoading extends RemoteCharactersState {
  const RemoteCharactersLoading();
}

class RemoteCharactersSuccess extends RemoteCharactersState {
  const RemoteCharactersSuccess(List<CharacterEntity> list) : super(characters: list);
}

class RemoteCharactersError extends RemoteCharactersState {
  const RemoteCharactersError(DioException e) : super(dioException: e);
}
