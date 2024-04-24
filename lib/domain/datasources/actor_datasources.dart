import 'package:cinemapedia_app/domain/entities/actor.dart';

abstract class ActorDataSource {
  Future<List<Actor>> getActorByMovieId(String movieId);
}
