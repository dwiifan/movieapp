import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movieapp/providers/movie_get_discover_provider.dart';
import 'package:movieapp/widget/item_movie_widget.dart';
import 'package:provider/provider.dart';

class ComponentsDiscoverMovie extends StatefulWidget {
  const ComponentsDiscoverMovie({super.key});

  @override
  State<ComponentsDiscoverMovie> createState() => _WidgetDiscoverMovieState();
}

class _WidgetDiscoverMovieState extends State<ComponentsDiscoverMovie> {
  //Nah disini kita mengambil data yg ada di Provider
  //Kemudian kita panggil nama variable yg ada di MovieGetDiscoverProvider yaitu getDicover
  @override
  //Fungsi initState digunakan untuk memanggil data cukup 1 kali di dalam class WidgetDiscoverMovie
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDicover(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        //di builder kita tidak perlu contextnya dan childnya karna yg kita perlukan valuenya, valuenya adalah provider
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
              ),
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Text(
                  'Not found discover movies',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            //Disini kita menggunakan CarouselSlider agar UInya bisa di slider
            return CarouselSlider.builder(
              //Ini panjangnya disesuaikan dengan yg ada di api
              itemCount: provider.movies.length,
              //Kemudian kita mengambil data dan tambilkan datanya
              itemBuilder: (_, index, __) {
                final movie = provider.movies[index];
                // image network kita beri kurung karna image tersebut bersifar bisa digunakan atau tidak '?'
                return ItemMovieWidget(
                  movie: movie,
                  heightBackdrop: 300,
                  widthBackdrop: double.infinity,
                  heightPoster: 160,
                  widthPoster: 100,
                );
              },
              options: CarouselOptions(
                height: 300,
                viewportFraction: 0.8,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                enlargeCenterPage: true,
                scrollDirection: Axis.horizontal,
              ),
            );
          }

          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            height: 300.0,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Center(
              child: Text(
                'Not found discover movies',
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
