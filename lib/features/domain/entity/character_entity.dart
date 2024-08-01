import 'package:equatable/equatable.dart';

class CharacterEntity extends Equatable {
  final int? id;
  final String? name;
  final String? status;
  final String? species;
  final String? type;
  final String? gender;
  final OriginAndLocationEntity? origin;
  final OriginAndLocationEntity? location;
  final String? image;
  final List<String>? episode;
  final String? url;
  final String? created;

  const CharacterEntity(
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

  @override
  List<Object?> get props {
    return [
      id,
      name,
      status,
      species,
      type,
      gender,
      origin,
      location,
      image,
      episode,
      url,
      created
    ];
  }
}

class OriginAndLocationEntity {
  final String? name;
  final String? url;

  const OriginAndLocationEntity({this.name, this.url});
}
