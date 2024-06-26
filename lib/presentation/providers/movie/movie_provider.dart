import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/presentation/providers/movie/movie_repository_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final nowPlayingMovieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final fetchMoreMovies = ref.watch(movieRepositoryProvider).getNowPlaying;
  return MovieNotifier(fetchMoreMovies: fetchMoreMovies);
});

final popularMovieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final fetchPopularMovies = ref.watch(movieRepositoryProvider).getPopular;
  return MovieNotifier(fetchMoreMovies: fetchPopularMovies);
});

final topRatedMovieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final fetchTopRatedMovies = ref.watch(movieRepositoryProvider).getTopRated;
  return MovieNotifier(fetchMoreMovies: fetchTopRatedMovies);
});

final upComingMovieProvider =
    StateNotifierProvider<MovieNotifier, List<Movie>>((ref) {
  final fetchUpComingMovies = ref.watch(movieRepositoryProvider).getUpComing;
  return MovieNotifier(fetchMoreMovies: fetchUpComingMovies);
});

typedef MovieCallBack = Future<List<Movie>> Function({int page});

class MovieNotifier extends StateNotifier<List<Movie>> {
  int currentPage = 0;
  MovieCallBack fetchMoreMovies;
  bool isLoading = false;

  MovieNotifier({required this.fetchMoreMovies}) : super([]);

  Future<void> loadNextPage() async {
    if (isLoading) return;
    isLoading = true;

    currentPage++;
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);
    state = [...state, ...movies];

    await Future.delayed(const Duration(milliseconds: 300));
    isLoading = false;
  }
}
