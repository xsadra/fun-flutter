import 'dart:collection';

import 'package:flutter/foundation.dart';

import 'person.dart';

class DataModel extends ChangeNotifier {
  final List<Person> _people = [];

  int get count => _people.length;

  UnmodifiableListView<Person> get people => UnmodifiableListView(_people);

  void addPerson(Person person) {
    _people.add(person);
    notifyListeners();
  }

  void removePerson(Person person) {
    _people.remove(person);
    notifyListeners();
  }

  void updatePerson(Person person) {
    final index = _people.indexOf(person);
    final oldPerson = _people.elementAt(index);
    if (person.isNotSamePerson(person: oldPerson)) {
      _people[index] = oldPerson.copyWith(
        name: person.name,
        age: person.age,
      );
      notifyListeners();
    }
  }
}
