import 'package:dartz/dartz.dart';
import 'package:movieapp/models/movie_model.dart';

abstract class MovieRepository {
//Repository berfungsi untuk menghubungan http clien atau server / Models
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1});
  // Jadi disini menggunakan fungsi Future dan mengembalikan MovieResponseModel karna di sana ada page/results/totalPages
  //Fungsi Either dari package dartz (L) artinya gagal (R) artinya berhasil, karna disini kita gunakan untuk menampilkan error maka kita gunakan String disampingnya
  //Repository berfungsi untuk menghubungan http clien atau server / Models
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1});
  // Jadi disini menggunakan fungsi Future dan mengembalikan MovieResponseModel karna di sana ada page/results/totalPages
  //Fungsi Either dari package dartz (L) artinya gagal (R) artinya berhasil, karna disini kita gunakan untuk menampilkan error maka kita gunakan String disampingnya
  Future<Either<String, MovieResponseModel>> getNowPlaying({int page = 1});
  // Jadi disini menggunakan fungsi Future dan mengembalikan MovieResponseModel karna di sana ada page/results/totalPages
  //Fungsi Either dari package dartz (L) artinya gagal (R) artinya berhasil, karna disini kita gunakan untuk menampilkan error maka kita gunakan String disampingnya
}
