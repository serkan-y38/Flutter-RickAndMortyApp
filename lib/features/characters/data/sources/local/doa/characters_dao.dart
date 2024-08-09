import 'package:floor/floor.dart';
import 'package:rickandmorty/features/characters/data/models/local/character_model.dart';

@dao
abstract class CharactersDao {
  @Insert()
  Future<void> insertCharacter(CharacterModel model);

  @delete
  Future<void> deleteCharacter(CharacterModel model);

  @Query("SELECT * FROM characters_table")
  Future<List<CharacterModel>> getSavedCharacters();

  @Query('SELECT EXISTS(SELECT 1 FROM characters_table WHERE id = :id LIMIT 1)')
  Future<bool?> isCharacterSaved(int id);
}
