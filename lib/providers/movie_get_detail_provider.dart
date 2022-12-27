import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_detail_model.dart';
import 'package:movieapp/repostories/movie_repository.dart';

class MovieGetDetailProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetDetailProvider(this._movieRepository);

  MovieDetailModel? _movie;
  MovieDetailModel? get movie => _movie;

  void getDetail(BuildContext context, {required int id}) async {
    final result = await _movieRepository.getDetail(id: id);
    result.fold(
      (massageError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(massageError),
          ),
        );
        _movie = null;
        notifyListeners();
        return null;
      },
      (response) {
        _movie = response;
        notifyListeners();
        return null;
      },
    );
  }
}
