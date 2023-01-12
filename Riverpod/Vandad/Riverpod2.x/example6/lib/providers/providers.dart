import 'package:example6/models/film.dart';
import 'package:example6/notifiers/notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

enum FavoriteStatus {
  all,
  favorite,
  notFavorite,
}

extension FavoriteStatusExtension on FavoriteStatus {
  IconData get iconData {
    switch (this) {
      case FavoriteStatus.all:
        return Icons.all_inclusive;
      case FavoriteStatus.favorite:
        return Icons.favorite;
      case FavoriteStatus.notFavorite:
        return Icons.favorite_border_outlined;
      default:
        return Icons.error_outline;
    }
  }
}

final favoriteStatusProvider = StateProvider<FavoriteStatus>(
  (_) => FavoriteStatus.all,
);

final allFilmsProvider = StateNotifierProvider<FilmNotifier, List<Film>>(
  (_) => FilmNotifier(),
);

final favoriteFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where(
        (film) => film.isFavorite,
      ),
);

final notFavoriteFilmsProvider = Provider<Iterable<Film>>(
  (ref) => ref.watch(allFilmsProvider).where(
        (film) => !film.isFavorite,
      ),
);
