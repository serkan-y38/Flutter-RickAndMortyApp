import 'package:rickandmorty/features/domain/entity/character_entity.dart';

class CharactersResponse {
  Info? info;
  List<Results>? results;

  CharactersResponse({this.info, this.results});

  factory CharactersResponse.fromJson(Map<String, dynamic> json) {
    return CharactersResponse(
      info: json['info'] != null ? Info.fromJson(json['info']) : null,
      results: json['results'] != null
          ? List<Results>.from(json['results'].map((x) => Results.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (info != null) {
      data['info'] = info!.toJson();
    }
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Info {
  int? count;
  int? pages;
  String? next;
  String? prev;

  Info({this.count, this.pages, this.next, this.prev});

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
        count: json['count'] ?? 0,
        pages: json['pages'] ?? 0,
        next: json['next'] ?? "",
        prev: json['prev'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['pages'] = pages;
    data['next'] = next;
    data['prev'] = prev;
    return data;
  }
}

class Results {
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  OriginAndLocation? origin;
  OriginAndLocation? location;
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  Results(
      {this.id,
        this.name,
        this.status,
        this.species,
        this.type,
        this.gender,
        this.origin,
        this.location,
        this.image,
        this.episode,
        this.url,
        this.created});

  CharacterEntity toDomain() {
    return CharacterEntity(
      created: created,
      episode: episode,
      gender: gender,
      id: id,
      image: image,
      name: name,
      species: species,
      status: status,
      type: type,
      url: url,
    );
  }

  factory Results.fromJson(Map<String, dynamic> json) {
    return Results(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      status: json['status'] ?? "",
      species: json['species'] ?? "",
      type: json['type'] ?? "",
      gender: json['gender'] ?? "",
      origin: json['origin'] != null
          ? OriginAndLocation.fromJson(json['origin'])
          : null,
      location: json['location'] != null
          ? OriginAndLocation.fromJson(json['location'])
          : null,
      image: json['image'] ?? "",
      episode: json['episode'] != null
          ? List<String>.from(json['episode'])
          : null,
      url: json['url'] ?? "",
      created: json['created'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['species'] = species;
    data['type'] = type;
    data['gender'] = gender;
    if (origin != null) {
      data['origin'] = origin!.toJson();
    }
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['image'] = image;
    data['episode'] = episode;
    data['url'] = url;
    data['created'] = created;
    return data;
  }
}

class OriginAndLocation {
  String? name;
  String? url;

  OriginAndLocation({this.name, this.url});

  factory OriginAndLocation.fromJson(Map<String, dynamic> json) {
    return OriginAndLocation(name: json['name'] ?? "", url: json['url'] ?? "");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}
