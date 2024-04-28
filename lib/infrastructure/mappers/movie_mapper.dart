import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:cinemapedia_app/infrastructure/models/models.dart';

class MovieMapper {
  static const String baseImageUrlPath = "https://image.tmdb.org/t/p/w500";
  static const String noPosterFound =
      "https://lascrucesfilmfest.com/wp-content/uploads/2018/01/no-poster-available.jpg";

  static Movie movieDBToEntity(MovieMovieDB movieDB) => Movie(
      adult: movieDB.adult,
      backdropPath: movieDB.backdropPath != ''
          ? baseImageUrlPath + movieDB.backdropPath
          : noPosterFound,
      genreIds: movieDB.genreIds.map((e) => e.toString()).toList(),
      id: movieDB.id,
      originalLanguage: movieDB.originalLanguage,
      originalTitle: movieDB.originalTitle,
      overview: movieDB.overview,
      popularity: movieDB.popularity,
      posterPath: movieDB.posterPath != ''
          ? baseImageUrlPath + movieDB.posterPath
          : noPosterFound,
      releaseDate: movieDB.releaseDate,
      title: movieDB.title,
      video: movieDB.video,
      voteAverage: movieDB.voteAverage,
      voteCount: movieDB.voteCount);

  static Movie movieDetailsToEntity(MovieDetails movieDetails) => Movie(
      adult: movieDetails.adult,
      backdropPath: movieDetails.backdropPath != ''
          ? baseImageUrlPath + movieDetails.backdropPath
          : noPosterFound,
      genreIds:
          movieDetails.genres.map((genre) => genre.name.toString()).toList(),
      id: movieDetails.id,
      originalLanguage: movieDetails.originalLanguage,
      originalTitle: movieDetails.originalTitle,
      overview: movieDetails.overview,
      popularity: movieDetails.popularity,
      posterPath: movieDetails.posterPath != ''
          ? baseImageUrlPath + movieDetails.posterPath
          : "no-poster",
      releaseDate: movieDetails.releaseDate,
      title: movieDetails.title,
      video: movieDetails.video,
      voteAverage: movieDetails.voteAverage,
      voteCount: movieDetails.voteCount);
}
