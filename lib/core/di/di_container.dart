import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rickandmorty/features/characters/data/repository/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/data/sources/local/app_database.dart';
import 'package:rickandmorty/features/characters/data/sources/remote/character_api_service/character_api_service.dart';
import 'package:rickandmorty/features/characters/domain/repository/characters_repository.dart';
import 'package:rickandmorty/features/characters/domain/use_case/local/delete_character_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/local/get_saved_characters_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/local/insert_character_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/local/is_character_saved_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/remote/get_characters_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/remote/get_characters_with_ids_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/remote/get_episode_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/remote/search_character_use_case.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/local/local_characters_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_with_ids/remote/remote_characters_with_ids_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/episode/remote/remote_episode_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/search_character/remote_search_character_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/characters/presentation/bloc/theme/theme_bloc.dart';

final singleton = GetIt.instance;

Future<void> initializeDependencies() async {

  final preference = await SharedPreferences.getInstance();

  singleton.registerSingleton<ThemeBloc>(ThemeBloc(preference));

  final localDatabase =
  await $FloorAppDatabase.databaseBuilder('app_database.db').build();

  singleton.registerSingleton<AppDatabase>(localDatabase);

  singleton.registerSingleton<Dio>(Dio());

  singleton
      .registerSingleton<CharacterApiService>(CharacterApiService(singleton()));

  singleton.registerSingleton<CharactersRepository>(
      CharactersRepositoryImpl(singleton(), singleton()));

  singleton.registerSingleton<GetCharactersUseCase>(
      GetCharactersUseCase(singleton()));

  singleton
      .registerSingleton<GetEpisodeUseCase>(GetEpisodeUseCase(singleton()));

  singleton.registerSingleton<GetCharactersWithIdsUseCase>(
      GetCharactersWithIdsUseCase(singleton()));

  singleton.registerSingleton<SearchCharacterUseCase>(
      SearchCharacterUseCase(singleton()));

  singleton.registerSingleton<InsertCharacterUseCase>(
      InsertCharacterUseCase(singleton()));

  singleton.registerSingleton<DeleteCharacterUseCase>(
      DeleteCharacterUseCase(singleton()));

  singleton.registerSingleton<GetSavedCharactersUseCase>(
      GetSavedCharactersUseCase(singleton()));

  singleton.registerSingleton<IsCharacterSavedUseCase>(
      IsCharacterSavedUseCase(singleton()));

  singleton.registerFactory<RemoteCharactersBloc>(
          () => RemoteCharactersBloc(singleton()));

  singleton
      .registerFactory<RemoteEpisodeBloc>(() => RemoteEpisodeBloc(singleton()));

  singleton.registerFactory<RemoteCharactersWithIdsBloc>(
          () => RemoteCharactersWithIdsBloc(singleton()));

  singleton.registerFactory<RemoteSearchCharacterBloc>(
          () => RemoteSearchCharacterBloc(singleton()));

  singleton.registerFactory<LocalCharactersBloc>(() =>
      LocalCharactersBloc(singleton(), singleton(), singleton(), singleton()));
}
