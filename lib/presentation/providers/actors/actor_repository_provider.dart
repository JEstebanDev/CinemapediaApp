import 'package:cinemapedia_app/infrastructure/datasources/actor_moviedb_datasource.dart';
import 'package:cinemapedia_app/infrastructure/repositories/actor_repository_impl.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
// This Repo is Immutable
final actorRepositoryProvider =
Provider((ref) => ActorRepositoryImplementation(ActorMovieDBDatasource()));
