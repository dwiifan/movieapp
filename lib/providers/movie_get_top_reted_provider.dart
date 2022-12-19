import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/repostories/movie_repository.dart';

class MovieGetTopRatedProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetTopRatedProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  //Mengambil data page pertama
  void getTopRated(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.getTopRated();

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
        //supaya datanya tidak diambil 2x
        _movies.clear();
        //mengambil data
        _movies.addAll(response.results);

        _isLoading = false;
        notifyListeners();

        return null;
      },
    );
  }

  //Mengambil data seterusnya
  void getTopRatedWithPagination(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    final result = await _movieRepository.getTopRated(page: page);

    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
          ),
        );

        pagingController.error = errorMessage;

        return;
      },
      (response) {
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          pagingController.appendPage(response.results, page + 1);
        }
        return null;
      },
    );
  }
}
