// CustomOperators
void main(List<String> args) {
// Part 01 - Add to Same class together
  final me = FamilyMember(name: 'Sadra');
  final you = FamilyMember(name: 'Sara');
  final family = me + you;
  print(family);

  // Part 02 -  Multiplying an Iterable
  const numbers = ['one', 'two', 'three'];
  final result = numbers * 3;
  print(result);

  // Part 03 - Addition of Two Optional Integers
  print(add(null, null));
  print(add(1, null));
  print(add(null, 10));
  print(add(1, 10));

  // Part 04 - Subtracting a String from Another String
  print('Foo Bar' - 'Foo');

  // Part 05 - Subtracting an Iterable from Another Iterable
  print([10, 12, 33, 45, 0] - [12, 0]);

  // Part 06 - Custom Operators on Map
  print({'name': 'Sadra', 'age': 28} + {'address': '321 Main St'});
  print({'name': 'Sadra', 'age': 28} - {'age': 28});
  print({'name': 'Sadra', 'age': 28} * 3);

  // Part 07 - Cross Data Type Operators
  final me2 = Person(name: 'Sadra');
  final you2 = Person(name: 'Sara');
  final son = Person(name: 'nik');
  final daughter = Person(name: 'jeny');
  final cat = Pet(name: 'Catty');
  final us = me2 + you2;
  final usWithCat = us & cat;
  final withSon = usWithCat + son;
  final withDaughter = withSon + daughter;
  final sonWithCat = son & cat;
  final withSonAndCat = withDaughter ^ sonWithCat;
  print('$withSonAndCat');
}

// Part 01 - Add to Same class together
class FamilyMember {
  final String name;

  const FamilyMember({
    required this.name,
  });

  @override
  String toString() => 'Family member (name = $name)';
}

class Family {
  final List<FamilyMember> members;

  const Family({
    required this.members,
  });

  @override
  String toString() => 'Family (members = $members)';
}

extension ToFamily on FamilyMember {
  Family operator +(FamilyMember other) => Family(
        members: [this, other],
      );
}
// Part 01 - END

// Part 02 -  Multiplying an Iterable
extension Times<T> on Iterable<T> {
  Iterable<T> operator *(int times) sync* {
    for (var i = 0; i < times; i++) {
      yield* this;
    }
  }
}
// Part 02 - END

// Part 03 - Addition of Two Optional Integers
int add([int? a, int? b]) {
  return a + b;
}

extension NullableAdd<T extends num> on T? {
  T operator +(T? other) {
    final thisShadow = this;
    if (this != null && other == null) {
      return this as T;
    } else if (this == null && other != null) {
      return other;
    } else if (thisShadow != null && other != null) {
      return thisShadow + other as T;
    } else {
      return 0 as T;
    }
  }
}
// Part 03 - END

// Part 04 - Subtracting a String from Another String
extension Remove on String {
  String operator -(String other) => replaceAll(
        other,
        '',
      );
}
// Part 04 - END

// Part 05 - Subtracting an Iterable from Another Iterable
extension RemoveList<T> on Iterable<T> {
  Iterable<T> operator -(Iterable<T> other) =>
      where((element) => !other.contains(element));
}
// Part 05 - END

// Part 06 - Custom Operators on Map
extension MapOperations<K, V> on Map<K, V> {
  Map<K, V> operator +(Map<K, V> other) => {
        ...this,
        ...other,
      };

  Map<K, V> operator -(Map<K, V> other) {
    return {...this}..removeWhere((key, value) {
        return other.containsKey(key) && other[key] == value;
      });
  }

  Iterable<Map<K, V>> operator *(int times) sync* {
    for (var i = 0; i < times; i++) {
      yield this;
    }
  }
}
// Part 06 - END

// Part 07 - Cross Data Type Operators
class Person {
  final String name;
  const Person({
    required this.name,
  });
  @override
  String toString() => 'Person (name = $name)';
}

class Pet {
  final String name;
  const Pet({
    required this.name,
  });
  @override
  String toString() => 'Pet (name = $name)';
}

class Family2 {
  final List<Person> members;
  final List<Pet> pets;

  const Family2({
    required this.members,
    required this.pets,
  });

  @override
  String toString() => 'Family (members = $members, pets = $pets)';
}

extension on Person {
  Family2 operator +(Person other) => Family2(
        members: [this, other],
        pets: [],
      );
  Family2 operator &(Pet other) => Family2(
        members: [this],
        pets: [other],
      );
}

extension on Family2 {
  Family2 operator &(Pet other) => Family2(
        members: members,
        pets: [
          ...pets,
          other,
        ],
      );

  Family2 operator +(Person other) => Family2(
        members: [
          ...members,
          other,
        ],
        pets: pets,
      );

  Family2 operator ^(Family2 other) => Family2(
        members: [
          ...members,
          ...other.members,
        ],
        pets: [
          ...pets,
          ...other.pets,
        ],
      );
}
// Part 07 - END
