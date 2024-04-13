import 'package:cinemapedia_app/config/constants/environment.dart';
import 'package:cinemapedia_app/domain/datasources/movies_datasources.dart';
import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia_app/infrastructure/models/moviedb/moviedb_response.dart';
import 'package:dio/dio.dart';

class MovieDBDatasource extends MovieDataSource {
  final dio = Dio(BaseOptions(
      baseUrl: "https://api.themoviedb.org/3",
      queryParameters: {
        "api_key": Environment.movieDBKey,
        "language": "es-CO"
      }));

  List<Movie> _jsonToMovies(Response<dynamic> response) {
    final movieDbResponse = MovieDbResponse.fromJson(response.data);
    final List<Movie> movies = movieDbResponse.results
        .where((element) => element.posterPath != "no-poster")
        .map((movie) => MovieMapper.movieDBToEntity(movie))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) async {
    final response =
        await dio.get("/movie/now_playing", queryParameters: {'page': page});
    return _jsonToMovies(response);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) async {
    final response =
        await dio.get("/movie/popular", queryParameters: {'page': page});
    return _jsonToMovies(response);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) async {
    final response =
        await dio.get("/movie/top_rated", queryParameters: {'page': page});
    return _jsonToMovies(response);
  }

  @override
  Future<List<Movie>> getUpComing({int page = 1}) async {
    final response =
        await dio.get("/movie/upcoming", queryParameters: {'page': page});
    return _jsonToMovies(response);
  }
}
