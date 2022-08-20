import 'package:dio/dio.dart';
import 'package:movies_app/models/movie.dart';
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

}











