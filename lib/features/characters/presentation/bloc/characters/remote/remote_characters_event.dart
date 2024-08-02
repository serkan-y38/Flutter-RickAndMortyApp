abstract class RemoteCharactersEvent {
  const RemoteCharactersEvent();
}

class GetCharacters extends RemoteCharactersEvent {
  const GetCharacters();
}

class LoadMoreCharacters extends RemoteCharactersEvent {
  const LoadMoreCharacters();
}