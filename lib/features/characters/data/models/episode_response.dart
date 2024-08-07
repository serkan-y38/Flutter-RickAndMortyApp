import 'package:rickandmorty/features/characters/domain/entity/episode_entity.dart';

class EpisodeResponse {
  int? id;
  String? name;
  String? airDate;
  String? episode;
  List<String>? characters;
  String? url;
  String? created;

  EpisodeResponse(
      {this.id,
      this.name,
      this.airDate,
      this.episode,
      this.characters,
      this.url,
      this.created});

  EpisodeEntity toDomain() {
    return EpisodeEntity(
        id: id,
        name: name,
        airDate: airDate,
        episode: episode,
        characters: characters,
        url: url,
        created: created);
  }

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) {
    return EpisodeResponse(
        id: json['id'] ?? 0,
        name: json['name'] ?? "",
        airDate: json['air_date'] ?? "",
        episode: json['episode'] ?? "",
        characters: json['characters'] != null
            ? List<String>.from(json['characters'])
            : null,
        url: json['url'] ?? "",
        created: json['created'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['air_date'] = airDate;
    data['episode'] = episode;
    data['characters'] = characters;
    data['url'] = url;
    data['created'] = created;
    return data;
  }
}
