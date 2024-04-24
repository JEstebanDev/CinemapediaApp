import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/actor_datasources.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/models.dart';
import 'package:dio/dio.dart';

class ActorMovieDBDatasource extends ActorDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        "api_key": Environment.movieDBKey,
        "language": "es-CO"
      }));

  @override
  Future<List<Actor>> getActorByMovieId(String movieId) async {
    final response = await dio.get("/movie/$movieId/credits");
    final actorMovieDbResponse = CreditsResponse.fromJson(response.data);
    final List<Actor> actors = actorMovieDbResponse.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();
    return actors;
  }
}
