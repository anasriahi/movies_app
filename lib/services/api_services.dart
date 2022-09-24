import 'package:dio/dio.dart';
import 'package:movies_app/models/movie.dart';
import 'package:movies_app/models/person.dart';
import 'package:movies_app/services/api.dart';

class APIService {
  final API api = API();
  final Dio dio = Dio();

  Future<Response> getData(String path, {Map<String, dynamic>? params}) async {
    // on construit l'url
    String _url = api.baseURL + path;

    // on construit les parametres de la requette
    // Ces parametres seront presents dans chaque requette
    Map<String, dynamic> query = {
      'api_key': api.apiKey,
      'language': 'fr-FR'
    };

    // si params n'est pas null, on ajoute son contenu à query
    if(params != null) {
      query.addAll(params);
    }

    // on fait l'app
    final response = await dio.get(_url, queryParameters: query);
    // on check si la requette à bien passé
    if(response.statusCode == 200) {
      return response;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getPopularMovies({required int pageNumber}) async {
    Response response = await getData('/movie/popular', params: {
      'page': pageNumber
    });

    if(response.statusCode == 200) {
      Map data = response.data;
      List<dynamic> results = data['results'];
      List<Movie> movies = [];
      for(Map<String, dynamic> json in results) {
        Movie movie = Movie.fromJson(json);
        movies.add(movie);
      }
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getNowPlaying({required int pageNumber}) async {
    Response response = await getData('/movie/now_playing', params: {
      'page': pageNumber
    });

    if(response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getUpComing({required int pageNumber}) async {
    Response response = await getData('/movie/upcoming', params: {
      'page': pageNumber
    });

    if(response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getAnimationMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie', params: {
      'page': pageNumber, 'with_genres': '16'
    });

    if(response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<List<Movie>> getActionMovies({required int pageNumber}) async {
    Response response = await getData('/discover/movie', params: {
      'page': pageNumber, 'with_genres': '28'
    });

    if(response.statusCode == 200) {
      Map data = response.data;
      List<Movie> movies = data['results'].map<Movie>((dynamic movieJson) {
        return Movie.fromJson(movieJson);
      }).toList();
      return movies;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    Response response = await getData('/movie/${movie.id}');
    if (response.statusCode == 200) {
      Map<String, dynamic> _data = response.data;
      var genres = _data['genres'] as List;
      List<String> genresList = genres.map((item) {
        return item['name'] as String;
      }).toList();

      Movie newMovie = movie.copyWith(
        genres: genresList,
        releaseDate: _data['release_date'],
        vote: _data['vote_average']
      );
      return newMovie;
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieVideos({ required Movie movie }) async {
    Response response = await getData('/movie/${movie.id}/videos');
    if (response.statusCode == 200) {
      Map _data = response.data;

      List<String> videoKeys = _data['results'].map<String>((videoJson) {
        return videoJson['key'] as String;
      }).toList();

      return movie.copyWith(videos: videoKeys);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieCasting({ required Movie movie }) async {
    Response response = await getData('/movie/${movie.id}/credits');
    if (response.statusCode == 200) {
      Map _data = response.data;

      List<Person> _casting = _data['cast'].map<Person>((dynamic personJson) {
        return Person.fromJson(personJson);
      }).toList();

      return movie.copyWith(casting: _casting);
    } else {
      throw response;
    }
  }

  Future<Movie> getMovieImages({ required Movie movie }) async {
    Response response = await getData('/movie/${movie.id}/images', params: {
      'include_image_language': 'null'
    });
    if (response.statusCode == 200) {
      // On récupère les images
      Map _data = response.data;
      List<String> imagePath = _data['backdrops'].map<String>((dynamic imageJson) {
        return imageJson['file_path'] as String;
      }).toList();

      return movie.copyWith(images: imagePath);
    } else {
      throw response;
    }
  }
}











