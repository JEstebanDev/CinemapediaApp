import 'package:cinemapedia_app/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/domain/repositories/movie_repository.dart';

class MovieRepositoryImplementation extends MovieRepository {
  final MovieDataSource dataSource;

  MovieRepositoryImplementation(this.dataSource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return dataSource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return dataSource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return dataSource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) {
    return dataSource.getUpComing(page: page);
  }
}
