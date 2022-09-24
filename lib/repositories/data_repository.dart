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
  final List<Movie> _animationMovieList = [];
  int _animationMoviePageIndex = 1;
  final List<Movie> _actionMovieList = [];
  int _actionMoviePageIndex = 1;

  //getters
  List<Movie> get popularMovieList => _popularMovieList;
  List<Movie> get nowPlayingList => _nowPlayingList;
  List<Movie> get upComingMovieList => _upComingMovieList;
  List<Movie> get animationMovieList => _animationMovieList;
  List<Movie> get actionMovieList => _actionMovieList;

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
      List<Movie> movies = await apiService.getUpComing(pageNumber: _upComingPageIndex);
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

  Future<void> getAnimationMovies() async {
    try {
      List<Movie> movies = await apiService.getAnimationMovies(pageNumber: _animationMoviePageIndex);
      _animationMovieList.addAll(movies);
      _animationMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print("ERROR: ${response.statusCode}");
      }
      rethrow;
    }
  }

  Future<void> getActionMovies() async {
    try {
      List<Movie> movies = await apiService.getActionMovies(pageNumber: _actionMoviePageIndex);
      _actionMovieList.addAll(movies);
      _actionMoviePageIndex++;
      notifyListeners();
    } on Response catch (response) {
      if (kDebugMode) {
        print("ERROR: ${response.statusCode}");
      }
      rethrow;
    }
  }

  Future<Movie> getMovieDetails({required Movie movie}) async {
    try {
      Movie newMovie = await apiService.getMovie(movie: movie);
      return newMovie;
    } on Response catch (response) {
      print("ERROR: ${response.statusCode}");
      rethrow;
    }
  }

  Future<void> initData() async {
    await Future.wait([
      getPopularMovies(),
      getNowPlaying(),
      getUpComingMovies(),
      getAnimationMovies(),
      getActionMovies()
    ]);
  }
}