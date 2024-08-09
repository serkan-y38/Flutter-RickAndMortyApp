import 'dart:convert';
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:rickandmorty/features/characters/data/models/local/character_model.dart';
import 'package:rickandmorty/features/characters/data/sources/local/doa/characters_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@TypeConverters([StringListConverter])
@Database(version: 1, entities: [CharacterModel])
abstract class AppDatabase extends FloorDatabase {
  CharactersDao get characterDao;
}

class StringListConverter extends TypeConverter<List<String>?, String?> {
  @override
  List<String>? decode(String? databaseValue) {
    if (databaseValue == null) {
      return [];
    }
    return List<String>.from(jsonDecode(databaseValue));
  }

  @override
  String? encode(List<String>? value) {
    return jsonEncode(value);
  }
}
