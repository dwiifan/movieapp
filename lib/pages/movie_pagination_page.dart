import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/providers/movie_get_discover_provider.dart';
import 'package:movieapp/providers/movie_get_top_reted_provider.dart';
import 'package:movieapp/widget/item_movie_widget.dart';
import 'package:provider/provider.dart';

enum TypeMovies { discover, topRated }

class MoviePaginationPage extends StatefulWidget {
  const MoviePaginationPage({super.key, required this.type});

  final TypeMovies type;

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  /* - Dibawah ini adalah sebuah controller paging
     - ItemTypenya kita ambil dari Model agar data yg ada dimodel dapat ditampilkan di ui
     - Kemudian firstPageKey kita mulai dari yg 1
  */
  final PagingController<int, MovieModel> _pagingController = PagingController(
    firstPageKey: 1,
  );

  /* - Fungsi ini adalah untuk mengambil data yg ada di provider, yaitu di provider movie_get_discover_provider
     - Disini kita juga perlu untuk memasukkan controllernya yaitu _pagingController kita ikutin yg ada di pub.dev
       infinite_scroll_pagination
     - Kemudian kita dari providernya di context.read<MovieGetDiscoverProvider> kemudian kita tarik data yg 
       getDicoverWithPaging pagingController kita ambil dari fungsi final pagenya kita ambil dari addPageRequestListener
       karna pageKeynya sudah kita setting di page 1 jadi nanti pagenya akan mengambil data dari page 1 terlebih dahulu
  */
  @override
  void initState() {
    _pagingController.addPageRequestListener(
      (pageKey) {
        switch (widget.type) {
          case TypeMovies.discover:
            context.read<MovieGetDiscoverProvider>().getDicoverWithPaging(
                  context,
                  pagingController: _pagingController,
                  page: pageKey,
                );
            break;
          case TypeMovies.topRated:
            context.read<MovieGetTopRatedProvider>().getTopRatedWithPagination(
                  context,
                  pagingController: _pagingController,
                  page: pageKey,
                );
            break;
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(builder: (_) {
          switch (widget.type) {
            case TypeMovies.discover:
              return const Text('Discover Movies');

            case TypeMovies.topRated:
              return const Text('Top Rated Movies');
          }
        }),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      //Disini kita menampilkan datanya ke ui
      body: PagedListView.separated(
        padding: EdgeInsets.all(16.0),
        pagingController: _pagingController,
        //Disini itemnya kita ambil dari MovieModel
        builderDelegate: PagedChildBuilderDelegate<MovieModel>(
          itemBuilder: (context, item, index) => ItemMovieWidget(
            //Nah movienya yg kita ambil itemnya karna itemnya itu kita narik dari <MovieModel>
            movie: item,
            heightBackdrop: 260,
            widthBackdrop: double.infinity,
            heightPoster: 140,
            widthPoster: 80,
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          height: 10,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
