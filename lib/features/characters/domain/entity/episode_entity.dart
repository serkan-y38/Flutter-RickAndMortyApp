import 'package:equatable/equatable.dart';

class EpisodeEntity extends Equatable {
  final int? id;
  final String? name;
  final String? airDate;
  final String? episode;
  final List<String>? characters;
  final String? url;
  final String? created;

  const EpisodeEntity(
      {this.id,
      this.name,
      this.airDate,
      this.episode,
      this.characters,
      this.url,
      this.created});

  @override
  List<Object?> get props =>
      [id, name, airDate, episode, characters, url, created];
}
