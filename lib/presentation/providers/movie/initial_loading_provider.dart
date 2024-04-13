import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final initialLoadingProvider = Provider<bool>(
  (ref) {
    final sliceShowMovies = ref.watch(movieSliceShowProvider).isEmpty;
    final popularMovies = ref.watch(popularMovieProvider).isEmpty;
    final topRatedMovies = ref.watch(topRatedMovieProvider).isEmpty;
    final upComingMovies = ref.watch(upComingMovieProvider).isEmpty;
    if (sliceShowMovies || popularMovies || topRatedMovies || upComingMovies) {
      return true;
    }
    return false;
  },
);
