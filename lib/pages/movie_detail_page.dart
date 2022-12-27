import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:movieapp/injector.dart';
import 'package:movieapp/providers/movie_get_detail_provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    //Pertama kita masukkna dlu providernnya yg sudah di daftarkan di lib Injector
    return ChangeNotifierProvider(
      create: (_) => sl<MovieGetDetailProvider>()..getDetail(context, id: id),
      builder: (_, __) => Scaffold(
        body: CustomScrollView(
          slivers: [
            Consumer<MovieGetDetailProvider>(
              builder: (_, provider, __) {
                if (provider.movie != null) {
                  log(provider.movie.toString());
                }

                return SliverAppBar(
                  title:
                      Text(provider.movie != null ? provider.movie!.title : ''),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
