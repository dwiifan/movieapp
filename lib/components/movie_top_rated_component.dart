import 'package:flutter/material.dart';
import 'package:movieapp/providers/movie_get_discover_provider.dart';
import 'package:movieapp/providers/movie_get_top_reted_provider.dart';
import 'package:movieapp/widget/image_widget.dart';
import 'package:provider/provider.dart';

class ComponentsTopRatedMovie extends StatefulWidget {
  const ComponentsTopRatedMovie({super.key});

  @override
  State<ComponentsTopRatedMovie> createState() => _WidgetDiscoverMovieState();
}

class _WidgetDiscoverMovieState extends State<ComponentsTopRatedMovie> {
  //Nah disini kita mengambil data yg ada di Provider
  //Kemudian kita panggil nama variable yg ada di MovieGetDiscoverProvider yaitu getDicover
  @override
  //Fungsi initState digunakan untuk memanggil data cukup 1 kali di dalam class WidgetDiscoverMovie
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetTopRatedProvider>().getTopRated(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        //memanggil data yg ada di main
        child: Consumer<MovieGetTopRatedProvider>(
          builder: (_, provider, __) {
            if (provider.isLoading) {
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Center(
                  child: Text(
                    'Not found top rated movies',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ),
              );
            }

            if (provider.movies.isNotEmpty) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                itemBuilder: (_, index) {
                  return ImageNetworkWidget(
                    imageSrc: provider.movies[index].posterPath,
                    height: 200,
                    width: 120,
                    radius: 12,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(
                  width: 8.0,
                ),
                itemCount: provider.movies.length,
              );
            }

            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: const Center(
                child: Text('Not found top rated movies'),
              ),
            );
          },
        ),
      ),
    );
  }
}
