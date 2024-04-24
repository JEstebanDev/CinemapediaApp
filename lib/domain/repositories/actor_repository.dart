import 'package:cinemapedia_app/domain/entities/actor.dart';

abstract class ActorRepository {
  Future<List<Actor>> getActorByMovieId(String movieId);
}
