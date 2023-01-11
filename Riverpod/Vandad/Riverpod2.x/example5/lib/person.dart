import 'package:uuid/uuid.dart';
import 'package:flutter/foundation.dart';

@immutable
class Person {
  final String name;
  final int age;
  final String uuid;

  Person({
    required this.name,
    required this.age,
    String? uuid,
  }) : uuid = uuid ?? const Uuid().v4();

  Person copyWith({
    String? name,
    int? age,
  }) {
    return Person(
      name: name ?? this.name,
      age: age ?? this.age,
      uuid: uuid,
    );
  }

  bool isSamePerson({required Person person}) {
    return person.name == name && person.age == age;
  }

  bool isNotSamePerson({required Person person}) {
    return person.name != name || person.age != age;
  }

  String get displayName => '$name with $age years old.';

  @override
  bool operator ==(covariant Person other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  @override
  String toString() {
    return 'Person{name: $name, age: $age, uuid: $uuid}';
  }
}
