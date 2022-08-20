import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_app/services/api_services.dart';

import '../models/movie.dart';

class DataRepository with ChangeNotifier {
  final APIService apiService = APIService();
  final List<Movie> _popularMovieList = [];
  int _popularMoviePageIndex = 1;
  final List<Movie> _nowPlayingList = [];
  int _nowPlayingPageIndex = 1;
  final List<Movie> _upComingMovieList = [];
  int _upComingPageIndex = 1;

  //getters
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlayingList => _nowPlayingList;
  List<Movie> get upComingMovieList => _upComingMovieList;

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

  Future<void> getNowPlaying() async {
    try {
      List<Movie> movies = await apiService.getNowPlaying(pageNumber: _nowPlayingPageIndex);
      _nowPlayingList.addAll(movies);
      _nowPlayingPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print("ERROR: ${response.statusCode}");
      }
      rethrow;
    }
  }

  Future<void> getUpComingMovies() async {
    try {
      List<Movie> movies = await apiService.getUpComing(pageNumber: _nowPlayingPageIndex);
      _upComingMovieList.addAll(movies);
      _upComingPageIndex++;
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print("ERROR: ${response.statusCode}");
      }
      rethrow;
    }
  }

  Future<void> initData() async {
    await getPopularMovies();
    await getNowPlaying();
    await getUpComingMovies();
  }
}