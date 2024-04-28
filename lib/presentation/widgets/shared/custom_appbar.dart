import 'package:cinemapedia_app/presentation/delegates/delegate.dart';
import 'package:cinemapedia_app/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomAppBar extends ConsumerWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Icon(
              Icons.movie_outlined,
              color: colors.primary,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              "Cinemapedia",
              style: titleStyle,
            ),
            const Spacer(),
            IconButton(
                onPressed: () {
                  final movieRepository = ref.read(movieRepositoryProvider);
                  showSearch(
                      context: context,
                      delegate: SearchMovieDelegate(
                          searchMovies: movieRepository.searchMovies));
                },
                icon: const Icon(Icons.search))
          ],
        ),
      ),
    ));
  }
}
