import 'package:flutter/material.dart';
import 'package:movieapp/providers/movie_get_discover_provider.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    //Nah disini kita mengambil data yg ada di Provider
    //Kemudian kita panggil nama variable yg ada di MovieGetDiscoverProvider yaitu getDicover
    context.read<MovieGetDiscoverProvider>().getDicover(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Movie DB'),
      ),
      //Consumer ini adalah widget dari provider untuk menampilkan data ke UI
      body: Consumer<MovieGetDiscoverProvider>(
        //di builder kita tidak perlu contextnya dan childnya karna yg kita perlukan valuenya, valuenya adalah provider
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.movies.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (context, index) {
                //nah disini kita ambil datanya yg ada di api kemudian kita masukkan indexnya index adalah data dari API
                final movie = provider.movies[index];

                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
              itemCount: provider.movies.length,
            );
          }

          return Center(
            child: Text('Not Found Discover Movies'),
          );
        },
      ),
    );
  }
}
