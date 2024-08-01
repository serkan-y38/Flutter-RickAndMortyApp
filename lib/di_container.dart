import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rickandmorty/features/data/repository/characters_repository_impl.dart';
import 'package:rickandmorty/features/data/sources/character_api_service/character_api_service.dart';
import 'package:rickandmorty/features/domain/repository/characters_repository.dart';
import 'package:rickandmorty/features/domain/use_case/get_characters_use_case.dart';
import 'package:rickandmorty/features/presentation/bloc/character/remote/remote_characters_bloc.dart';

final singleton = GetIt.instance;

Future<void> initializeDependencies() async {
  singleton.registerSingleton<Dio>(Dio());

  singleton.registerSingleton<CharacterApiService>(
      CharacterApiService(singleton()));

  singleton.registerSingleton<CharactersRepository>(
      CharactersRepositoryImpl(singleton()));

  singleton.registerSingleton<GetCharactersUseCase>(
      GetCharactersUseCase(singleton()));

  singleton.registerFactory<RemoteCharactersBloc>(
      () => RemoteCharactersBloc(singleton()));
}
