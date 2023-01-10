// Extensions
import 'dart:math' show Random;

void main(List<String> args) {
  // Part 01 - Extending String
  print('Hi Sadra!'.reversed);

  // Part 02 - Sum of Iterable
  print([3, 2, 1].sum);
  print([2.1, 3.1, 1.4].sum);

  // Part 03 - Range on int
  print(1.to(10));
  print(1.to(10, inclusive: false));
  print(10.to(1));

  // Part 04 - Finding Duplicate Values in Iterables
  print([1, 2, 3, 1].containsDuplicateValues);

  // Part 05 - Finding and Mapping Keys and Values on Map
  final String? ageAsString = json.find(
    'age',
    (int age) => age.toString(),
  );
  print(ageAsString);

  final String helloName = json.find(
    'name',
    (String name) => 'Hello, $name!',
  )!;
  print(helloName);

  final String? address = json.find(
    'address',
    (String address) => 'You live at $address',
  );
  print('address = $address');

  // Part 06 - Extending Enums
  print(AnimalType.goldFish.nameContainsUpperCaseLetters);

  // Part 07 - Extending Functions
  print(add.callWithRandomValues());
  print(subtract.callWithRandomValues());

  // Part 08 - Extension Overrides
  const jack = Person(
    name: 'Jack',
    age: 20,
  );
  print(ShortDescription(jack).description);
  print(LongDescription(jack).description);
}

// Part 01 - Extending String
extension on String {
  String get reversed => split('').reversed.join();
}
// Part 01 - END

// Part 02 - Sum of Iterable
extension SumOfIterable<T extends num> on Iterable<T> {
  T get sum => reduce((a, b) => a + b as T);
}
// Part 02- END

// Part 03 - Range on int
extension on int {
  Iterable<int> to(int end, {bool inclusive = true}) => end > this
      ? [for (var i = this; i < end; i++) i, if (inclusive) end]
      : [for (var i = this; i > end; i--) i, if (inclusive) end];
}
// Part 03 - END

// Part 04 - Finding Duplicate Values in Iterables
extension on Iterable {
  bool get containsDuplicateValues => toSet().length != length;
}
// Part 04 - END

// Part 05 - Finding and Mapping Keys and Values on Map
const json = {
  'name': 'Foo Bar',
  'age': 20,
};

extension Find<K, V, R> on Map<K, V> {
  R? find<T>(
    K key,
    R? Function(T value) cast,
  ) {
    final value = this[key];
    if (value != null && value is T) {
      return cast(value as T);
    } else {
      return null;
    }
  }
}
// Part 05 - END

// Part 06 - Extending Enums
enum AnimalType {
  cat,
  dog,
  goldFish,
}

extension on Enum {
  bool get nameContainsUpperCaseLetters => name.contains(
        RegExp(
          r'[A-Z]',
        ),
      );
}
// Part 06 - END

// Part 07 - Extending Functions
int add(int a, int b) => a + b;
int subtract(int a, int b) => a - b;

typedef IntFunction = int Function(int, int);

extension on IntFunction {
  int callWithRandomValues() {
    final rnd1 = Random().nextInt(100);
    final rnd2 = Random().nextInt(100);
    print('Random values = $rnd1, $rnd2');
    return call(
      rnd1,
      rnd2,
    );
  }
}
// Part 07 - END

// Part 08 - Extension Overrides
class Person {
  final String name;
  final int age;

  const Person({
    required this.name,
    required this.age,
  });
}

extension ShortDescription on Person {
  String get description => '$name ($age)';
}

extension LongDescription on Person {
  String get description => '$name is $age years old';
}
// Part 08 - END
