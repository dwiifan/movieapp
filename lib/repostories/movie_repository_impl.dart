import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:movieapp/models/movie_detail_model.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/repostories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
//Repository disini berfungsi untuk menghubungkan ke API atau http client

  final Dio _dio;

  MovieRepositoryImpl(this._dio);

  @override
  //karna disni menggunakan future maka kita harus menggunakan async await
  Future<Either<String, MovieResponseModel>> getDiscover({int page = 1}) async {
    /*disini kita buat sebuah fungsi yg namanya getDiscover fungsinya itu berfungsi untuk megambil data yg ada di
       _dio.get('/discover/movie', queryParameters: {'page': page}, result.data ada raw json dari server api kemudian 
       diubah ke MovieResponseModel dan akan dikembalikan ke MovieResponseModel jika datanya ada 200 jika kondisinya gagal
       maka akan dikembalikan ke kondisi yg error 401/400
    
    */
    //disini kita pastikan dlu kalo fungsi tersebut berjalan dengan menggunakan try catch
    //disini kita samakan karna MovieResponseModel menggunakan Either maka kita harus masukkan juga Eithernya disini
    try {
      final result = await _dio.get(
        '/discover/movie',
        queryParameters: {'page': page},
      ); //ini adalah request ke API

      //data ini di ambil dari raw json klo status codenya 200 maka akan menampilkan data yg ada di json
      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        //disini kita mengubah data dari json agak bisa ditampilkan di apk yg diambil result.data
        return Right(model);
        //nah disini fungsi Right(_r) kita menegunakan fungsi dartz/Either Rightnya akan masuk ke MovieResponseModel yg mereturn model
        //kemudian kita balikkan ke model karna bertype MovieResponseModel
      }

      //Disini jika kondisi diatas tidak terpenuhi atau 400/401 maka akan menampilkan error tersebut
      return const Left('Error get discover movies');
    } on DioError catch (e) {
      //disini kita cek error di dionya
      if (e.response != null) {
        return Left(e.response.toString());
        // disini kita menampilakn error tersebut karna apa
      }

      return const Left('Another error on get discover movie');
      //disini kita tidak bisa mengambil api

    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getTopRated({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/top_rated',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return left('Error get discover movies');
    } on DioError catch (e) {
      if (e.response != null) {
        Left(e.response.toString());
      }

      return const Left('Another error on get discover movie');
    }
  }

  @override
  Future<Either<String, MovieResponseModel>> getNowPlaying(
      {int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/now_playing',
        queryParameters: {'page': page},
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieResponseModel.fromMap(result.data);
        return Right(model);
      }

      return left('Error get now playing movies');
    } on DioError catch (e) {
      if (e.response != null) {
        Left(e.response.toString());
      }

      return const Left('Another error on get now playing movie');
    }
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetail({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id',
      );

      if (result.statusCode == 200 && result.data != null) {
        final model = MovieDetailModel.fromMap(result.data);
        return Right(model);
      }

      return left('Error get detail movies');
    } on DioError catch (e) {
      if (e.response != null) {
        Left(e.response.toString());
      }

      return const Left('Another error on get detail movie');
    }
  }
}
