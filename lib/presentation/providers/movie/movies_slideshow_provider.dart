import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'movie_provider.dart';

final movieSliceShowProvider = Provider<List<Movie>>((ref) {
  final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
  if(nowPlayingMovies.isEmpty) return [];
  return nowPlayingMovies.sublist(0,6);
});