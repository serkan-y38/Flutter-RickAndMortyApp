abstract class RemoteCharactersWithIdsEvent {
  final String? idList;

  const RemoteCharactersWithIdsEvent({this.idList});
}

class GetCharactersWithIds extends RemoteCharactersWithIdsEvent {
  const GetCharactersWithIds({super.idList});
}
