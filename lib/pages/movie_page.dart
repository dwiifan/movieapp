import 'package:flutter/material.dart';
import 'package:movieapp/components/movie_discover_component.dart';
import 'package:movieapp/components/movie_now_playing_component.dart';
import 'package:movieapp/components/movie_top_rated_component.dart';
import 'package:movieapp/pages/movie_pagination_page.dart';

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
            floating: true,
            snap: true,
            centerTitle: true,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          //------------------------------------------------//
          _WidgetTitle(
            title: 'Discover Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MoviePaginationPage(
                    type: TypeMovies.discover,
                  ),
                ),
              );
            },
          ),
          const ComponentsDiscoverMovie(),
          //------------------------------------------------//
          _WidgetTitle(
            title: 'Top Rated Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MoviePaginationPage(
                    type: TypeMovies.topRated,
                  ),
                ),
              );
            },
          ),
          const ComponentsTopRatedMovie(),
          //------------------------------------------------//
          _WidgetTitle(
            title: 'Now Playing Movies',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MoviePaginationPage(
                    type: TypeMovies.nowPlaying,
                  ),
                ),
              );
            },
          ),
          const ComponentMovieNowPlaying(),
          //------------------------------------------------//
        ],
      ),
    );
  }
}

class _WidgetTitle extends SliverToBoxAdapter {
  final String title;
  final void Function() onPressed;

  const _WidgetTitle({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            OutlinedButton(
              onPressed: onPressed,
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
      );
}
