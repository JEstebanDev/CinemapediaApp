import 'package:cinemapedia_app/domain/datasources/actor_datasources.dart';
import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/domain/repositories/actor_repository.dart';

class ActorRepositoryImplementation extends ActorRepository {
  final ActorDataSource dataSource;

  ActorRepositoryImplementation(this.dataSource);

  @override
  Future<List<Actor>> getActorByMovieId(String movieId) {
    return dataSource.getActorByMovieId(movieId);
  }
}
