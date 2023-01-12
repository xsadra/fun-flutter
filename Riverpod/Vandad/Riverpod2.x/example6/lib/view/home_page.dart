import 'package:example6/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/film.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Films'),
        actions: const [FilterWidget()],
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final filter = ref.watch(favoriteStatusProvider);
          switch (filter) {
            case FavoriteStatus.all:
              return FilmsWidget(provider: allFilmsProvider);
            case FavoriteStatus.favorite:
              return FilmsWidget(provider: favoriteFilmsProvider);
            case FavoriteStatus.notFavorite:
              return FilmsWidget(provider: notFavoriteFilmsProvider);
          }
        },
      ),
    );
  }
}

class FilmsWidget extends ConsumerWidget {
  const FilmsWidget({Key? key, required this.provider}) : super(key: key);

  final AlwaysAliveProviderBase<Iterable<Film>> provider;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final films = ref.watch(provider);
    return ListView.builder(
      itemCount: films.length,
      itemBuilder: (context, index) {
        final film = films.elementAt(index);
        final favoriteIcon = film.isFavorite
            ? const Icon(
                Icons.favorite,
                color: Colors.red,
              )
            : const Icon(Icons.favorite_border);
        return Column(
          children: [
            ListTile(
              title: Text(film.title),
              subtitle: Text(film.description),
              trailing: IconButton(
                  onPressed: () {
                    final isFavorite = !film.isFavorite;
                    ref
                        .read(allFilmsProvider.notifier)
                        .update(film, isFavorite);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'You ${isFavorite ? 'liked' : 'disliked'} ${film.title} movie.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: isFavorite
                            ? Colors.green.shade900
                            : Colors.deepPurple.shade900,
                      ),
                    );
                  },
                  icon: favoriteIcon),
            ),
            const Divider(
              color: Colors.black45,
              height: 10,
              thickness: 1,
            ),
          ],
        );
      },
    );
  }
}

class FilterWidget extends StatelessWidget {
  const FilterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return DropdownButton(
          value: ref.watch(favoriteStatusProvider),
          items: FavoriteStatus.values
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Icon(e.iconData),
                ),
              )
              .toList(),
          onChanged: (value) {
            // State is deprecated, change it
            // ref.read(favoriteStatusProvider.state).state = value!;
            ref.read(favoriteStatusProvider.notifier).state = value!;
          },
        );
      },
    );
  }
}
