import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/widget/image_widget.dart';

class ItemMovieWidget extends Container {
  final MovieModel movie;

  final double heightBackdrop;
  final double widthBackdrop;
  final double heightPoster;
  final double widthPoster;

  ItemMovieWidget({
    super.key,
    required this.movie,
    required this.heightBackdrop,
    required this.widthBackdrop,
    required this.heightPoster,
    required this.widthPoster,
  });

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
            height: heightBackdrop,
            width: widthBackdrop,
          ),
          Container(
            height: heightBackdrop,
            width: widthBackdrop,
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
                  height: heightPoster,
                  width: widthPoster,
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
