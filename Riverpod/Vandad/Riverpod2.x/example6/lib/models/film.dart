import 'package:flutter/foundation.dart';

@immutable
class Film {
  final String id;
  final String title;
  final String description;
  final bool isFavorite;

  const Film({
    required this.id,
    required this.title,
    required this.description,
    required this.isFavorite,
  });

  Film copy({
    bool? isFavorite,
  }) {
    return Film(
      id: id,
      title: title,
      description: description,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(covariant Film other) =>
      id == other.id && isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hashAll([id, isFavorite]);

  @override
  String toString() {
    return 'Film{'
        'id: $id, '
        'title: $title, '
        'description: $description, '
        'isFavorite: $isFavorite'
        '}';
  }
}

const allFilms = [
  Film(
    id: '1',
    title: 'A New Hope',
    description:
        'It is a period of civil war.Rebel spaceships, striking from a hidden base, have wont heir first victory against the evil Galactic Empire.',
    isFavorite: false,
  ),
  Film(
    id: '2',
    title: 'The Empire Strikes Back',
    description:
        'It is a dark time for theRebellion. Although the DeathStar has been destroyed',
    isFavorite: false,
  ),
  Film(
    id: '3',
    title: 'Return of the Jedi',
    description:
        'Luke Skywalker has returned to his home planet of x attempt to rescue his friend Han Solo from the clutches of the vile gangster',
    isFavorite: false,
  ),
  Film(
    id: '4',
    title: 'The Phantom Menace',
    description: 'Turmoil has engulfed theGalactic Republic. ',
    isFavorite: false,
  ),
  Film(
    id: '5',
    title: 'Attack of the Clones',
    description: 'There is unrest in the GalacticSenate. ',
    isFavorite: false,
  ),
  Film(
    id: '6',
    title: 'Revenge of the Seth',
    description:
        'War! The Republic is crumb ling under attacks by the ruthless Seth Lord, Count Dokku.There are heroes on both sides.',
    isFavorite: false,
  ),
  Film(
    id: '7',
    title: 'The Shaw-shank Redemption',
    description:
        'Two imprisoned men bond over a number of years, finding solace and eventual redemption through acts of common decency.',
    isFavorite: false,
  ),
  Film(
    id: '8',
    title: 'The Godfather',
    description:
        'The aging patriarch of an organized crime dynasty in postwar New York City transfers control of his clandestine empire to his reluctant youngest son.',
    isFavorite: false,
  ),
  Film(
    id: '9',
    title: 'The Dark Knight',
    description:
        'When the menace known as the Joker wreaks havoc and chaos on the people of Gotham, Batman must accept one of the greatest psychological and physical tests of his ability to fight injustice.',
    isFavorite: false,
  ),
  Film(
    id: '10',
    title: '12 Angry Men',
    description:
        'The jury in a New York City murder trial is frustrated by a single member whose skeptical caution forces them to more carefully consider the evidence before jumping to a hasty verdict.',
    isFavorite: false,
  ),
  Film(
    id: '11',
    title: 'Pulp Fiction',
    description:
        'The lives of two mob Hit-men, a boxer, a gangster and his wife, and a pair of diner bandits intertwine in four tales of violence and redemption.',
    isFavorite: false,
  ),
  Film(
    id: '12',
    title: 'Pleasure',
    description:
        'Behind the scenes of a porn shoot, the actors are practicing various positions. The rumor is that one of the girls is doing a double anal, an advanced routine that requires someone extremely tough.',
    isFavorite: false,
  ),
];
