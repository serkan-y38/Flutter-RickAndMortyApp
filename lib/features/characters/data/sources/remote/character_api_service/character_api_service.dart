import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:rickandmorty/features/characters/data/models/remote/characters_response.dart';
import 'package:rickandmorty/features/characters/data/models/remote/episode_response.dart';
import 'package:rickandmorty/core/constants.dart';

/** run "dart run build_runner build" to generate character_api_service.g.dart file */
part 'character_api_service.g.dart';

@RestApi(baseUrl: rickAndMortyApiBaseUrl)
abstract class CharacterApiService {
  factory CharacterApiService(Dio dio) = _CharacterApiService;

  @GET("/character")
  Future<HttpResponse<CharactersResponse>> getCharacters({
    @Query("page") int? page,
  });

  @GET("/character")
  Future<HttpResponse<CharactersResponse>> searchCharacter({
    @Query("page") int? page,
    @Query("name") String? name,
  });

  @GET("/character/{idList}")
  Future<HttpResponse<List<Results>>> getCharactersWithIds({
    @Path("idList") String? idList,
  });

  @GET("/episode/{id}")
  Future<HttpResponse<EpisodeResponse>> getEpisode({
    @Path("id") String? id,
  });
}
