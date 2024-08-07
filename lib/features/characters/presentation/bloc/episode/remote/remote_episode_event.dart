abstract class RemoteEpisodeEvent {
  final String? episodeId;

  const RemoteEpisodeEvent({this.episodeId});
}

class GetEpisode extends RemoteEpisodeEvent {
  const GetEpisode({super.episodeId});
}
