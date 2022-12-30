import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:movieapp/injector.dart';
import 'package:movieapp/pages/movie_page.dart';
import 'package:movieapp/providers/movie_get_discover_provider.dart';
import 'package:movieapp/providers/movie_get_now_playing_provider.dart';
import 'package:movieapp/providers/movie_get_top_reted_provider.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //masukkan class setup() agar data yg ada di injektor kita digunakan
  setup();
  runApp(MyApp());
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Kemudian data yg ada di injector kita ambil dengna menggunakan sl
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sl<MovieGetNowPlayingProvider>(),
        )
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
