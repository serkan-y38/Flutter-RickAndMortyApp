import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rickandmorty/features/characters/data/repository/characters_repository_impl.dart';
import 'package:rickandmorty/features/characters/data/sources/character_api_service/character_api_service.dart';
import 'package:rickandmorty/features/characters/domain/repository/characters_repository.dart';
import 'package:rickandmorty/features/characters/domain/use_case/get_characters_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/get_characters_with_ids_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/get_episode_use_case.dart';
import 'package:rickandmorty/features/characters/domain/use_case/search_character_use_case.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters/remote/remote_characters_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/characters_with_ids/remote/remote_characters_with_ids_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/episode/remote/remote_episode_bloc.dart';
import 'package:rickandmorty/features/characters/presentation/bloc/search_character/remote_search_character_bloc.dart';

final singleton = GetIt.instance;

Future<void> initializeDependencies() async {
  singleton.registerSingleton<Dio>(Dio());

  singleton
      .registerSingleton<CharacterApiService>(CharacterApiService(singleton()));

  singleton.registerSingleton<CharactersRepository>(
      CharactersRepositoryImpl(singleton()));

  singleton.registerSingleton<GetCharactersUseCase>(
      GetCharactersUseCase(singleton()));

  singleton
      .registerSingleton<GetEpisodeUseCase>(GetEpisodeUseCase(singleton()));

  singleton.registerSingleton<GetCharactersWithIdsUseCase>(
      GetCharactersWithIdsUseCase(singleton()));

  singleton.registerSingleton<SearchCharacterUseCase>(
      SearchCharacterUseCase(singleton()));

  singleton.registerFactory<RemoteCharactersBloc>(
      () => RemoteCharactersBloc(singleton()));

  singleton
      .registerFactory<RemoteEpisodeBloc>(() => RemoteEpisodeBloc(singleton()));

  singleton.registerFactory<RemoteCharactersWithIdsBloc>(
      () => RemoteCharactersWithIdsBloc(singleton()));

  singleton.registerFactory<RemoteSearchCharacterBloc>(
          () => RemoteSearchCharacterBloc(singleton()));
}
