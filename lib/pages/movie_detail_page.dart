import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:movieapp/widget/item_movie_widget.dart';
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
            _WidgetAppBar(context),
            _WidgetSunmary(),
          ],
        ),
      ),
    );
  }
}

class _WidgetAppBar extends SliverAppBar {
  final BuildContext context;

  _WidgetAppBar(this.context);

  @override
  Color? get backgroundColor => Colors.white;

  @override
  Color? get foregroundColor => Colors.black;

  @override
  // TODO: implement leading
  Widget? get leading => Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
            ),
          ),
        ),
      );

  @override
  List<Widget>? get actions => [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.public,
              ),
            ),
          ),
        )
      ];

  @override
  double? get expandedHeight => 300;

  @override
  Widget? get flexibleSpace => Consumer<MovieGetDetailProvider>(
        builder: (_, provider, __) {
          final movie = provider.movie;

          if (movie != null) {
            return ItemMovieWidget(
              movieDetail: movie,
              heightBackdrop: double.infinity,
              widthBackdrop: double.infinity,
              heightPoster: 160.0,
              widthPoster: 100,
              radius: 0,
            );
          }

          return Container(
            color: Colors.black12,
            height: double.infinity,
            width: double.infinity,
          );
        },
      );
}

class _WidgetSunmary extends SliverToBoxAdapter {
  Widget _content({
    required String title,
    required Widget body,
  }) =>
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8.0,
          ),
          body,
          const SizedBox(
            height: 12.0,
          ),
        ],
      );

  TableRow _tableContent({required String title, required String context}) =>
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(context),
        )
      ]);

  @override
  Widget? get child => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<MovieGetDetailProvider>(
          builder: (_, provider, __) {
            final movie = provider.movie;

            if (movie != null) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _content(
                    title: 'Release Date',
                    body: Row(
                      children: [
                        const Icon(
                          Icons.calendar_month_rounded,
                        ),
                        const SizedBox(
                          width: 6.0,
                        ),
                        Text(
                          movie.releaseDate.toString().split(' ').first,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                  _content(
                    title: 'Genres',
                    body: Wrap(
                      spacing: 6,
                      children: movie.genres
                          .map((genre) => Chip(label: Text(genre.name)))
                          .toList(),
                    ),
                  ),
                  _content(title: 'Overview', body: Text(movie.overview)),
                  _content(
                    title: 'Sunmary',
                    body: Table(
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0: FlexColumnWidth(1),
                        1: FlexColumnWidth(2),
                      },
                      border: TableBorder.all(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      children: [
                        _tableContent(
                          title: 'Adult',
                          context: movie.adult ? 'Yes' : 'No',
                        ),
                        _tableContent(
                          title: 'Popularity',
                          context: '${movie.popularity}',
                        ),
                        _tableContent(
                          title: 'Status',
                          context: movie.status,
                        ),
                        _tableContent(
                          title: 'Budget',
                          context: '${movie.budget}',
                        ),
                        _tableContent(
                          title: 'Revenue',
                          context: '${movie.revenue}',
                        ),
                        _tableContent(
                          title: 'Tagline',
                          context: movie.tagline,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Container();
          },
        ),
      );
}
