import 'package:cinemapedia_app/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// This Repo is Immutable
final movieRepositoryProvider =
    Provider((ref) => MovieRepositoryImplementation(MovieDBDatasource()));
