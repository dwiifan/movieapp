import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movieapp/app_constants.dart';
import 'package:movieapp/pages/movie_page.dart';
import 'package:movieapp/providers/movie_get_discover_provider.dart';
import 'package:movieapp/repostories/movie_repository.dart';
import 'package:movieapp/repostories/movie_repository_impl.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //Disini kita buat injek"nya secara manual
  //oke disini kita ambil data yg ada di MovieRepositoryImpl jangan lupa kita buat jga DIOnya agar bisa digunakan _dionya
  //disini kita buat juga dioOptionnya agar dionya dapat menarik data dengan yg kita mau, kemudian kita masukkan ke DIOnya
  final dioOptions = BaseOptions(
    baseUrl: AppConstants.baseUrl,
    queryParameters: {
      'api_key': AppConstants.apiKey,
    },
  );

  final Dio dio = Dio(dioOptions);
  final MovieRepository movieRepository = MovieRepositoryImpl(dio);

  runApp(MyApp(
    movieRepository: movieRepository,
  ));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final MovieRepository movieRepository;
  const MyApp({
    super.key,
    required this.movieRepository,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MovieGetDiscoverProvider(movieRepository),
        ),
      ],
      child: MaterialApp(
        title: 'Movie DB',
        theme: ThemeData(),
        home: MoviePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
