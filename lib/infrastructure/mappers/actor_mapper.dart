import 'package:cinemapedia_app/domain/entities/actor.dart';
import 'package:cinemapedia_app/infrastructure/models/creditsdb/creditsdb_response.dart';

class ActorMapper {
  static const String baseImageUrlPath = "https://image.tmdb.org/t/p/w500";
  static const String noPosterFound =
      "https://ih1.redbubble.net/image.1861329650.2941/flat,750x,075,f-pad,750x1000,f8f8f8.jpg";

  static Actor castToEntity(Cast cast) => Actor(
      id: cast.id,
      name: cast.name,
      profilePath: cast.profilePath != ''
          ? '$baseImageUrlPath${cast.profilePath}'
          : noPosterFound,
      character: cast.character);
}
