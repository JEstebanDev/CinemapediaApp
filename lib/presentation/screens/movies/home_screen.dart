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
  }

  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMovieProvider);
    final sliceShowMovies = ref.watch(movieSliceShowProvider);
    if (sliceShowMovies.isEmpty) {
      return const CircularProgressIndicator();
    }
    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: false,
          title: CustomAppBar(),
          background: ColoredBox(color: Colors.white),
          titlePadding: EdgeInsets.only(top: 5, bottom: 5, left: 0, right: 0),
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
              movies: nowPlayingMovies,
              title: 'Popular',
              loadNextPage: () =>
                  ref.read(nowPlayingMovieProvider.notifier).loadNextPage(),
            ),
            MovieHorizontalListView(
              movies: nowPlayingMovies,
              title: 'Best Qualified',
              subTitle: 'All times movies',
              loadNextPage: () =>
                  ref.read(nowPlayingMovieProvider.notifier).loadNextPage(),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        );
      }, childCount: 1))
    ]);
  }
}
