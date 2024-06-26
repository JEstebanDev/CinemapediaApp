import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia_app/config/helpers/human_formats.dart';
import 'package:flutter/material.dart';

import 'package:cinemapedia_app/domain/entities/movie.dart';
import 'package:go_router/go_router.dart';

class MovieHorizontalListView extends StatefulWidget {
  final List<Movie> movies;
  final String? title;
  final String? subTitle;
  final VoidCallback? loadNextPage;

  const MovieHorizontalListView(
      {super.key,
      required this.movies,
      this.title,
      this.subTitle,
      this.loadNextPage});

  @override
  State<MovieHorizontalListView> createState() =>
      _MovieHorizontalListViewState();
}

class _MovieHorizontalListViewState extends State<MovieHorizontalListView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (widget.loadNextPage == null) return;
      if ((scrollController.position.pixels + 200) >=
          scrollController.position.maxScrollExtent) {
        widget.loadNextPage!();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 370,
      child: Column(
        children: [
          if (widget.title != null || widget.subTitle != null)
            _Title(
              title: widget.title,
              subTitle: widget.subTitle,
            ),
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: widget.movies.length,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      FadeIn(child: _Slide(movie: widget.movies[index]))))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Movie movie;

  const _Slide({required this.movie});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final voteAverage = movie.voteAverage.toStringAsFixed(1);
    final popularity = HumanFormats.number(movie.popularity);
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  movie.posterPath,
                  width: 150,
                  height: 230,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress != null) {
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 2),
                        child: Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      );
                    }
                    return GestureDetector(
                        onTap: () => context.push('/movie/${movie.id}'),
                        child: FadeIn(child: child));
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
                width: 150,
                height: 40,
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          movie.title,
                          maxLines: 2,
                          style: textStyle.titleSmall,
                          textAlign: TextAlign.left,
                        ),
                      )),
                )),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: 150,
              child: Row(
                children: [
                  Icon(
                    Icons.star_half_outlined,
                    color: Colors.yellow.shade800,
                  ),
                  const SizedBox(
                    width: 3,
                  ),
                  Text(
                    voteAverage,
                    style: textStyle.bodyMedium
                        ?.copyWith(color: Colors.yellow.shade800),
                  ),
                  const Spacer(),
                  Text(
                    popularity,
                    style: textStyle.bodyMedium,
                  )
                ],
              ),
            )
          ],
        ));
  }
}

class _Title extends StatelessWidget {
  final String? title;
  final String? subTitle;

  const _Title({this.title, this.subTitle});

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleLarge;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          if (title != null) Text(title!, style: titleStyle),
          const Spacer(),
          if (subTitle != null)
            FilledButton.tonal(
                style: const ButtonStyle(visualDensity: VisualDensity.compact),
                onPressed: () {},
                child: Text(subTitle!)),
        ],
      ),
    );
  }
}
