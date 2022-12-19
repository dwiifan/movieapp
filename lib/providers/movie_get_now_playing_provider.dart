import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/repostories/movie_repository.dart';

class MovieGetNowPlayingProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetNowPlayingProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void getNowPlaying(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.getNowPlaying();

    result.fold(
      (massageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(massageError),
          ),
        );
        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return;
      },
    );
  }

  void getNowPlayingWithPaging(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final result = await _movieRepository.getNowPlaying(page: page);

    result.fold(
      (massageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(massageError),
          ),
        );
        pagingController.error = massageError;
        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
        return;
      },
    );
  }
}
