import 'package:equatable/equatable.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';

abstract class LocalCharactersEvent extends Equatable {
  final CharacterEntity? entity;
  final int? id;

  const LocalCharactersEvent({this.entity, this.id});

  @override
  List<Object?> get props => [entity!];
}

class GetSavedCharacters extends LocalCharactersEvent {
  const GetSavedCharacters();
}

class InsertCharacter extends LocalCharactersEvent {
  const InsertCharacter(CharacterEntity entity) : super(entity: entity);
}

class DeleteCharacter extends LocalCharactersEvent {
  const DeleteCharacter(CharacterEntity entity) : super(entity: entity);
}

class IsCharacterSaved extends LocalCharactersEvent {
  const IsCharacterSaved(int id) : super(id: id);
}
