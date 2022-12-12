import 'package:flutter/material.dart';
import 'package:movieapp/app_constants.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/providers/movie_get_discover_provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:movieapp/widget/image_widget.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Consumer ini adalah widget dari provider untuk menampilkan data ke UI
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Text('Movie DB'),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Discover Movies',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      shape: const StadiumBorder(),
                      side: const BorderSide(
                        color: Colors.black54,
                      ),
                    ),
                    child: const Text(
                      'See All',
                    ),
                  ),
                ],
              ),
            ),
          ),
          WidgetDiscoverMovie(),
        ],
      ),
    );
  }
}

class WidgetDiscoverMovie extends StatefulWidget {
  const WidgetDiscoverMovie({super.key});

  @override
  State<WidgetDiscoverMovie> createState() => _WidgetDiscoverMovieState();
}

class _WidgetDiscoverMovieState extends State<WidgetDiscoverMovie> {
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
                return ItemMovie(movie);
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

class ItemMovie extends Container {
  final MovieModel movie;

  ItemMovie(this.movie, {super.key});

  //Memberi border radius pada sisi container
  @override
  Clip get clipBehavior => Clip.hardEdge;

  // Memberikan border radius pada sisi border
  @override
  Decoration? get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      );

  @override
  Widget? get child => Stack(
        children: [
          //Disini kita mengambil Widget dari ImageNetworkWidget
          ImageNetworkWidget(
            //Karna image tersebut bersifat bisa kosong atau berisi atau nullsef maka kita harus bungkus dengan '${}'
            imageSrc: '${movie.backdropPath}',
            height: 300,
            width: double.infinity,
          ),
          Container(
            height: 300,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black87,
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageNetworkWidget(
                  //Karna image tersebut bersifat double maka kita harus bungkus dengan '${}'
                  imageSrc: '${movie.posterPath}',
                  height: 150,
                  width: 100,
                  radius: 12,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  movie.title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.star_rounded,
                      color: Colors.amber,
                    ),
                    Text(
                      //Karna voteAverage itu bersifat double maka kita berikan dia kutip
                      '${movie.voteAverage} (${movie.voteCount})',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      );
}
