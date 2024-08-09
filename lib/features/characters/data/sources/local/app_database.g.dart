// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  CharactersDao? _characterDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `characters_table` (`id` INTEGER, `name` TEXT, `status` TEXT, `species` TEXT, `type` TEXT, `gender` TEXT, `originUrl` TEXT, `originName` TEXT, `locationUrl` TEXT, `locationName` TEXT, `image` TEXT, `episode` TEXT, `url` TEXT, `created` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  CharactersDao get characterDao {
    return _characterDaoInstance ??= _$CharactersDao(database, changeListener);
  }
}

class _$CharactersDao extends CharactersDao {
  _$CharactersDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _characterModelInsertionAdapter = InsertionAdapter(
            database,
            'characters_table',
            (CharacterModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'species': item.species,
                  'type': item.type,
                  'gender': item.gender,
                  'originUrl': item.originUrl,
                  'originName': item.originName,
                  'locationUrl': item.locationUrl,
                  'locationName': item.locationName,
                  'image': item.image,
                  'episode': _stringListConverter.encode(item.episode),
                  'url': item.url,
                  'created': item.created
                }),
        _characterModelDeletionAdapter = DeletionAdapter(
            database,
            'characters_table',
            ['id'],
            (CharacterModel item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'status': item.status,
                  'species': item.species,
                  'type': item.type,
                  'gender': item.gender,
                  'originUrl': item.originUrl,
                  'originName': item.originName,
                  'locationUrl': item.locationUrl,
                  'locationName': item.locationName,
                  'image': item.image,
                  'episode': _stringListConverter.encode(item.episode),
                  'url': item.url,
                  'created': item.created
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<CharacterModel> _characterModelInsertionAdapter;

  final DeletionAdapter<CharacterModel> _characterModelDeletionAdapter;

  @override
  Future<List<CharacterModel>> getSavedCharacters() async {
    return _queryAdapter.queryList('SELECT * FROM characters_table',
        mapper: (Map<String, Object?> row) => CharacterModel(
            row['id'] as int?,
            row['name'] as String?,
            row['status'] as String?,
            row['species'] as String?,
            row['type'] as String?,
            row['gender'] as String?,
            row['originUrl'] as String?,
            row['originName'] as String?,
            row['locationUrl'] as String?,
            row['locationName'] as String?,
            row['image'] as String?,
            _stringListConverter.decode(row['episode'] as String?),
            row['url'] as String?,
            row['created'] as String?));
  }

  @override
  Future<bool?> isCharacterSaved(int id) async {
    return _queryAdapter.query(
        'SELECT EXISTS(SELECT 1 FROM characters_table WHERE id = ?1 LIMIT 1)',
        mapper: (Map<String, Object?> row) => (row.values.first as int) != 0,
        arguments: [id]);
  }

  @override
  Future<void> insertCharacter(CharacterModel model) async {
    await _characterModelInsertionAdapter.insert(
        model, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteCharacter(CharacterModel model) async {
    await _characterModelDeletionAdapter.delete(model);
  }
}

// ignore_for_file: unused_element
final _stringListConverter = StringListConverter();
