import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rickandmorty/core/resource.dart';
import 'package:rickandmorty/features/characters/data/sources/character_api_service/character_api_service.dart';
import 'package:rickandmorty/features/characters/domain/entity/character_entity.dart';
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
}
