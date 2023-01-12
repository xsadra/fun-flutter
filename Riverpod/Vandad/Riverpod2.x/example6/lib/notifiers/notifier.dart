import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/film.dart';

class FilmNotifier extends StateNotifier<List<Film>> {
  FilmNotifier() : super(allFilms);

  void update(Film film, bool isFavorite) {
    state = state
        .map((element) => element.id == film.id
            ? element.copy(isFavorite: isFavorite)
            : element)
        .toList();
  }
}
