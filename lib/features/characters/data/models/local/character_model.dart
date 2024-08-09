import 'package:floor/floor.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';

@Entity(tableName: "characters_table")
class CharacterModel {
  @PrimaryKey()
  int? id;
  String? name;
  String? status;
  String? species;
  String? type;
  String? gender;
  String? originUrl;
  String? originName;
  String? locationUrl;
  String? locationName;
  String? image;
  List<String>? episode;
  String? url;
  String? created;

  CharacterModel(
      this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,
      this.originUrl,
      this.originName,
      this.locationUrl,
      this.locationName,
      this.image,
      this.episode,
      this.url,
      this.created);

  CharacterEntity toDomain() {
    return CharacterEntity(
        id: id,
        name: name,
        status: status,
        species: species,
        type: type,
        gender: gender,
        origin: OriginAndLocationEntity(name: originName, url: originUrl),
        location: OriginAndLocationEntity(name: locationName, url: locationUrl),
        image: image,
        episode: episode,
        url: url,
        created: created);
  }

  static CharacterModel toData(CharacterEntity entity) {
    return CharacterModel(
        entity.id,
        entity.name,
        entity.status,
        entity.species,
        entity.type,
        entity.gender,
        entity.origin!.url!,
        entity.origin!.name!,
        entity.location!.url,
        entity.location!.url,
        entity.image,
        entity.episode,
        entity.url,
        entity.created);
  }
}
