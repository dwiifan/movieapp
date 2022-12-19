import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/repostories/movie_repository.dart';

//fungsi ChangeNotifier adalah untuk memberi tahu kalau ada perubahan state didalam provider yg kita buat ini
class MovieGetDiscoverProvider with ChangeNotifier {
  //Disini kita memanggil repositorynya kemudian kita beri nama/variable _movieRepository
  final MovieRepository _movieRepository;

  MovieGetDiscoverProvider(this._movieRepository); //ini adalah constraktor

  bool _isLoading = false;
  bool get isLoading => _isLoading; //disini ada proses loading terlebih dahulu
  //Nah disini kita buat list model untuk mengambil data yg ada di API dengan nama _movies kemudian kita ambil data movies yg ada di API
  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  //Oke disini kita buat sebuah fungsi yg namanya getDicover()
  void getDicover(BuildContext context) async {
    //disini kita kasih loding supaya kita tahu kalo proses tersebut sedang mengambil data
    _isLoading = true;
    notifyListeners(); //Kita kasih notifyListeners agar loading tersebut dapaet berfungsi
    //disini kita ambil getDiscover yg ada di movie_repository karna getDiscover bersifat Future maka kita kasih async await
    final result = await _movieRepository.getDiscover();

    //disini kita kasih kondisi data tersebut dapat berjalan dengan baik atau tidak
    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));

        _isLoading = false;
        notifyListeners();
        return;
      },
      (response) {
        //Fungsi ini agar kita refresh data tersebut tidak di ambil lagi jadi datannya tetap yg ada di API kalo kita menggunakan ini maka datanya akan bertambah
        _movies.clear();
        //Jika tidak error kita ambil semua ada list yg ada di API nah veluesnya kita ambil dari
        _movies.addAll(response.results);
        _isLoading = false;
        notifyListeners();
        return null;
      },
    );
  }

  //Ini adalah fungsion dari pagination
  //Disini kita tambah 1 properti {required int page,} berfungsi untuk memanggil datanya ditaruh di getDiscover
  void getDicoverWithPaging(
    BuildContext context, {
    required PagingController pagingController,
    required int page,
  }) async {
    //disini kita ambil getDiscover yg ada di movie_repository karna getDiscover bersifat Future maka kita kasih async await
    final result = await _movieRepository.getDiscover(page: page);

    //disini kita kasih kondisi data tersebut dapat berjalan dengan baik atau tidak
    result.fold(
      //Ini jika kondisinya gagal
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage),
        ));

        pagingController.error = errorMessage;

        return;
      },
      (response) {
        /*Disini kita membuat list akhir jadi kalo datanya sudah mencapai 20 maka data sudah tidak di proses kita liat di 
        results ada berapa data, setelah kita lihat ternyata ada 20 data, jadi kita maxkan 20, appendLastPage adalah
        data list terakhir
      */
        if (response.results.length < 20) {
          pagingController.appendLastPage(response.results);
        } else {
          /* Nah disini kita buat liat terus berjalana kita ambil datanya di results kemudian di tambah dengan menggunakan
          page + 1 agar datanya dapat diambil semua
         */
          pagingController.appendPage(response.results, page + 1);
        }
        return null;
      },
    );
  }
}
