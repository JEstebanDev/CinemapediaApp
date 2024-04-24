import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/presentation/providers/actors/actor_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final actorMovieProvider =
    StateNotifierProvider<ActorByMovieNotifier, Map<String, List<Actor>>>((ref) {
  final actorsRepository = ref.watch(actorRepositoryProvider);
  return ActorByMovieNotifier(
      fetchActorByMovieId: actorsRepository.getActorByMovieId);
});

typedef GetActorCallBack = Future<List<Actor>> Function(String movieId);

class ActorByMovieNotifier extends StateNotifier<Map<String, List<Actor>>> {
  GetActorCallBack fetchActorByMovieId;

  ActorByMovieNotifier({required this.fetchActorByMovieId}) : super({});

  Future<void> loadActor(String movieId) async {
    if (state[movieId] != null) return;
    final List<Actor> actors = await fetchActorByMovieId(movieId);
    state = {...state, movieId: actors};
  }
}
