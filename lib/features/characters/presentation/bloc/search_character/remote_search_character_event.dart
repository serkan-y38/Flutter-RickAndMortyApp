abstract class RemoteSearchCharacterEvent {
  String? name;

  RemoteSearchCharacterEvent(this.name);
}

class SearchCharacters extends RemoteSearchCharacterEvent {
  SearchCharacters(super.name);
}

class LoadMoreSearchCharacter extends RemoteSearchCharacterEvent {
  LoadMoreSearchCharacter(super.name);
}
