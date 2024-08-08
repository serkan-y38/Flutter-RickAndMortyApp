import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/features/characters/data/sources/character_api_service/character_api_service.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
import 'package:rickandmorty/features/characters/domain/entity/episode_entity.dart';
import 'package:rickandmorty/features/characters/domain/repository/characters_repository.dart';

class CharactersRepositoryImpl implements CharactersRepository {
  final CharacterApiService _characterApiService;

  CharactersRepositoryImpl(this._characterApiService);

  @override
  Future<Resource<List<CharacterEntity>>> getCharacters(int? page) async {
    try {
      Loading;
      final res = await _characterApiService.getCharacters(page: page);
      if (res.response.statusCode == HttpStatus.ok) {
        var data = res.data.results?.map((e) => e.toDomain()).toList();
        return Success(data ?? []);
      } else {
        return Error(DioException(
            error: res.response.statusMessage,
            response: res.response,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions));
      }
    } on DioException catch (e) {
      return Error(DioException(
          error: e.error,
          response: null,
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions()));
    }
  }

  @override
  Future<Resource<List<CharacterEntity>>> searchCharacter(
      int? page, String? name) async {
    try {
      Loading;
      final res =
          await _characterApiService.searchCharacter(page: page, name: name);
      if (res.response.statusCode == HttpStatus.ok) {
        var data = res.data.results?.map((e) => e.toDomain()).toList();
        return Success(data ?? []);
      } else {
        return Error(DioException(
            error: res.response.statusMessage,
            response: res.response,
            type: DioExceptionType.badResponse,
            requestOptions: res.response.requestOptions));
      }
    } on DioException catch (e) {
      return Error(DioException(
          error: e.error,
          response: null,
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions()));
    }
  }

  @override
  Future<Resource<EpisodeEntity>> getEpisode(String? id) async {
    try {
      Loading;
      final response = await _characterApiService.getEpisode(id: id);
      if (response.response.statusCode == HttpStatus.ok) {
        var data = response.data.toDomain();
        return Success(data);
      } else {
        return Error(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions));
      }
    } on DioException catch (e) {
      return Error(DioException(
          error: e.error,
          response: null,
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions()));
    }
  }

  @override
  Future<Resource<List<CharacterEntity>>> getCharactersWithIds(
      String idList) async {
    try {
      Loading;
      final response =
          await _characterApiService.getCharactersWithIds(idList: idList);
      if (response.response.statusCode == HttpStatus.ok) {
        var data = response.data
            .map((toElement) => {toElement.toDomain()})
            .expand((element) => element)
            .toList();
        return Success(data);
      } else {
        return Error(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions));
      }
    } on DioException catch (e) {
      return Error(DioException(
          error: e.error,
          response: null,
          type: DioExceptionType.unknown,
          requestOptions: RequestOptions()));
    }
  }
}
