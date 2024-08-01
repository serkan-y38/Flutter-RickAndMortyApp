import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:rickandmorty/features/data/models/characters_response.dart';
import '../../../../core/constants.dart';

/** run "dart run build_runner build" to generate character_api_service.g.dart file */
part 'character_api_service.g.dart';

@RestApi(baseUrl: rickAndMortyApiBaseUrl)
abstract class CharacterApiService {
  factory CharacterApiService(Dio dio) = _CharacterApiService;

  @GET("/character")
  Future<HttpResponse<CharactersResponse>> getCharacters();
}
