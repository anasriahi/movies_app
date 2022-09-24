import 'package:movies_app/models/person.dart';
import 'package:movies_app/services/api.dart';

class Movie {
  final int id;
  final String name;
  final String description;
  final String? posterPath;
  final List<String>? genres;
  final String? releaseDate;
  final double? vote;
  final List<String>? videos;
  final List<Person>? casting;
  final List<String>? images;

  const Movie(
      {required this.id,
      required this.name,
      required this.description,
      this.posterPath,
      this.genres,
      this.releaseDate,
      this.vote,
      this.videos,
      this.casting,
      this.images});

  Movie copyWith(
      {int? id,
      String? name,
      String? description,
      String? posterPath,
      List<String>? genres,
      String? releaseDate,
      double? vote,
      List<String>? videos,
      List<Person>? casting,
      List<String>? images}) {
    return Movie(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        posterPath: posterPath ?? this.posterPath,
        genres: genres ?? this.genres,
        releaseDate: releaseDate ?? this.releaseDate,
        vote: vote ?? this.vote,
        videos: videos ?? this.videos,
        casting: casting ?? this.casting,
        images: images ?? this.images
    );
  }

  factory Movie.fromJson(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      name: map['title'] as String,
      description: map['overview'] as String,
      posterPath: map['poster_path'] as String,
    );
  }

  String posterURL() {
    API api = API();
    return api.baseImageURL + posterPath!;
  }

  String reformatGenres() {
    String categories = '';
    for (int i = 0; i < genres!.length; i++) {
      if (i == genres!.length - 1) {
        categories = categories + genres![i];
      } else {
        categories = categories + '${genres![i]}, ';
      }
    }
    return categories;
  }
}
