import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinemapedia_app/presentation/widgets/widgets.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = "home-screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _HomeView(),
      bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMovieProvider.notifier).loadNextPage();
    ref.read(popularMovieProvider.notifier).loadNextPage();
    ref.read(topRatedMovieProvider.notifier).loadNextPage();
    ref.read(upComingMovieProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();
    final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
    final sliceShowMovies = ref.watch(movieSliceShowProvider);
    final popularMovies = ref.watch(popularMovieProvider);
    final topRatedMovies = ref.watch(topRatedMovieProvider);
    final upComingMovies = ref.watch(upComingMovieProvider);

    return Visibility(
        visible: !initialLoading,
        child: CustomScrollView(slivers: [
          const SliverAppBar(
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: CustomAppBar(),
              background: ColoredBox(color: Colors.white),
              titlePadding:
                  EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              children: [
                MovieSliceShow(movies: sliceShowMovies),
                MovieHorizontalListView(
                  movies: nowPlayingMovies,
                  title: 'In Theaters',
                  subTitle: 'Monday 20th',
                  loadNextPage: () =>
                      ref.read(nowPlayingMovieProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListView(
                  movies: popularMovies,
                  title: 'Popular',
                  loadNextPage: () =>
                      ref.read(popularMovieProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListView(
                  movies: topRatedMovies,
                  title: 'Top Rated',
                  subTitle: 'Best Movies',
                  loadNextPage: () =>
                      ref.read(topRatedMovieProvider.notifier).loadNextPage(),
                ),
                MovieHorizontalListView(
                  movies: upComingMovies,
                  title: 'UpComing',
                  subTitle: 'Soon in theaters',
                  loadNextPage: () =>
                      ref.read(upComingMovieProvider.notifier).loadNextPage(),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            );
          }, childCount: 1))
        ]));
  }
}
