import 'package:flutter/material.dart';
import 'package:movieapp/models/movie_detail_model.dart';
import 'package:movieapp/models/movie_model.dart';
import 'package:movieapp/widget/image_widget.dart';

class ItemMovieWidget extends Container {
  final MovieModel? movie;
  final MovieDetailModel? movieDetail;
  final double heightBackdrop;
  final double widthBackdrop;
  final double heightPoster;
  final double widthPoster;
  final double radius;
  final void Function()? onTap;

  ItemMovieWidget({
    super.key,
    required this.heightBackdrop,
    required this.widthBackdrop,
    required this.heightPoster,
    required this.widthPoster,
    this.radius = 12,
    this.movie,
    this.movieDetail,
    this.onTap,
  });

  //Memberi border radius pada sisi container
  @override
  Clip get clipBehavior => Clip.hardEdge;

  // Memberikan border radius pada sisi border
  @override
  Decoration? get decoration => BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
      );

  @override
  Widget? get child => Stack(
        children: [
          //Disini kita mengambil Widget dari ImageNetworkWidget
          ImageNetworkWidget(
            //Karna image tersebut bersifat bisa kosong atau berisi atau nullsef maka kita harus bungkus dengan '${}'
            imageSrc:
                '${movieDetail != null ? movieDetail!.backdropPath : movie!.backdropPath}',
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
                  imageSrc:
                      '${movieDetail != null ? movieDetail!.posterPath : movie!.posterPath}',
                  height: heightPoster,
                  width: widthPoster,
                  radius: 12,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  movieDetail != null ? movieDetail!.title : movie!.title,
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
                      '${movieDetail != null ? movieDetail!.voteAverage : movie!.voteAverage} (${movieDetail != null ? movieDetail!.voteCount : movie!.voteCount})',
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
          //Fungsinya untuk memberi efek jika container tersebut sedang di klik
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
              ),
            ),
          ),
        ],
      );
}
