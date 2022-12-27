import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/providers/movie_get_now_playing_provider.dart';
import 'package:movieapp/widget/image_widget.dart';
import 'package:provider/provider.dart';

class ComponentMovieNowPlaying extends StatefulWidget {
  const ComponentMovieNowPlaying({super.key});

  @override
  State<ComponentMovieNowPlaying> createState() =>
      _ComponentMovieNowPlayingState();
}

class _ComponentMovieNowPlayingState extends State<ComponentMovieNowPlaying> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetNowPlayingProvider>().getNowPlaying(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 200,
        //memanggil data yg ada di main
        child: Consumer<MovieGetNowPlayingProvider>(
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
                    'Not found now playing movies',
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                  ),
                ),
              );
            }

            //Disini menggunakan ListView.separated karna kita membutuhkan separatorBuilder untuk mengukur lebarnya
            if (provider.movies.isNotEmpty) {
              return ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                itemBuilder: (_, index) {
                  final movie = provider.movies[index];
                  return Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: 200,
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black12,
                          ]),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Row(
                      children: [
                        ImageNetworkWidget(
                          imageSrc: movie.posterPath,
                          height: 200,
                          width: 120,
                          radius: 12,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                movie.title,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                ),
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
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                movie.overview,
                                maxLines: 3,
                                style: const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                child: Text('Not found now playing movies'),
              ),
            );
          },
        ),
      ),
    );
  }
}
