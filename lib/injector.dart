import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movieapp/providers/movie_get_detail_provider.dart';
import 'package:movieapp/providers/movie_get_discover_provider.dart';
import 'package:movieapp/providers/movie_get_now_playing_provider.dart';
import 'package:movieapp/providers/movie_get_top_reted_provider.dart';
import 'package:movieapp/repostories/movie_repository.dart';
import 'package:movieapp/repostories/movie_repository_impl.dart';

import 'app_constants.dart';

final sl = GetIt.instance;

void setup() {
//Register Provider
  sl.registerFactory<MovieGetDiscoverProvider>(
      () => MovieGetDiscoverProvider(sl()));
  sl.registerFactory<MovieGetTopRatedProvider>(
      () => MovieGetTopRatedProvider(sl()));
  sl.registerFactory<MovieGetNowPlayingProvider>(
      () => MovieGetNowPlayingProvider(sl()));
  sl.registerFactory<MovieGetDetailProvider>(
      () => MovieGetDetailProvider(sl()));

//Register Repository
  //Disini kita buat injek"nya secara manual  MovieRepositoryImpl(sl())
  //oke disini kita ambil data yg ada di MovieRepositoryImpl jangan lupa kita buat jga DIOnya agar bisa digunakan slnya
  //disini kita buat juga dioOptionnya agar dionya dapat menarik data dengan yg kita mau, kemudian kita masukkan ke DIOnya
  sl.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sl()));

// Register Http Client atau masukkan DIOnya
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        queryParameters: {
          'api_key': AppConstants.apiKey,
        },
      ),
    ),
  );
}
