import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/services/api_services.dart';

import '../models/movie.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;

  //getters
  List<Movie> get popularMovieList => _popularMovieList;

  Future<void> getPopularMovies() async {
    try {
      List<Movie> movies = await apiService.getPopularMovies(pageNumber: _popularMoviePageIndex);
      _popularMovieList.addAll(movies);
      _popularMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print("ERROR: ${response.statusCode}");
      }
      rethrow;
    }
  }
}