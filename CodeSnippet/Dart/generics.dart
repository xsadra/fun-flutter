// Generics
void main(List<String> args) {
  // Part 01 - Generic Integer or Double
  final double doubleValue = eitherIntOrDouble();
  print(doubleValue);
  final int intValue = eitherIntOrDouble();
  print(intValue);

  // Part 02 - Type Matching
  print(doTypesMatch(1, 2));
  print(doTypesMatch(1, 2.2));

  // Part 03 - Constrained Generic Type Definitions
  const momAndDad = {
    'mom': Person(),
    'dad': Person(),
  };
  const brotherAndSisterAndMyFish = {
    'Brother': Person(),
    'Sister': Person(),
    'Fishy': Fish(),
  };

  final allValues = [
    momAndDad,
    brotherAndSisterAndMyFish,
  ];
  describe(allValues);

  // Part 04 - Unconstrained Generic Type Definitions
  const one = KeyValue(1, 2);
  print(one);
  const two = KeyValue(1, 2.2); // MapEntry<int, double>
  print(two);

  // Part 05 - Specializing Generic Type Definitions
  const JSON<String> json = {
    'name': 'John',
    'address': '123 Main St',
  };
  print(json);

  // Part 06 - Generic Mixins and Specialized Mixin Type Definitions
  const person = Person2(height: 1.7);
  const dog = Dog2(height: 1);
  print(person.height);
  print(dog.height);

  // Part 07 - Generic Classes with Generic Extensions
  const tuple = Tuple(1, 20.2);
  print(tuple);
  final swapped = tuple.swap();
  print(swapped);

  // Part 08 -  Generic Sorting with Comparable
  sort(ascending: false);
  sort(ascending: true);

  // Part 09 - Handling Lack of Common Ancestors
  print((2.2).toInt() == 2);
  print((2.0).toInt() == 2);
  print('3'.toInt() == 3);
  print(['2', '3.5'].toInt() == 6);
  print({'2', 3, '4.2'}.toInt() == 9);
  print(['2', 3, '4.2', 5.3].toInt() == 14);

  // Part 10 - Generic Extension on Any Data Type
  final personName = personThing.mapIfOfType(
        (Person3 p) => p.name,
      ) ??
      'Unknown person name';
  print(personName);

  final animalName = animalThing.mapIfOfType(
        (Animal a) => a.name,
      ) ??
      'Unknown animal name';
  print(animalName);

  // Part 11 - Generic Function Pointers

  // Part 12 - Generic Class Properties
}

// Part 01 - Generic Integer or Double
T eitherIntOrDouble<T extends num>() {
  switch (T) {
    case int:
      return 1 as T;
    case double:
      return 1.1 as T;
    default:
      throw Exception('Not supported');
  }
}
// Part 01 - END

// Part 02 - Type Matching
// bool doTypesMatch(Object a, Object b) {
//   return a.runtimeType == b.runtimeType;
// }

bool doTypesMatch<L, R>(L a, R b) => L == R;
// Part 02 - END

// Part 03 - Constrained Generic Type Definitions
typedef BreathingThings<T extends CanBreathe> = Map<String, T>;

void describe(Iterable<BreathingThings> values) {
  for (final map in values) {
    for (final keyAndValue in map.entries) {
      print('Will call breathe() on ${keyAndValue.key}');
      keyAndValue.value.breathe();
    }
  }
}

mixin CanBreathe {
  void breathe();
}

class Person with CanBreathe {
  const Person();
  @override
  void breathe() {
    print('Person is breathing...');
  }
}

class Fish with CanBreathe {
  const Fish();
  @override
  void breathe() {
    print('Fish is breathing...');
  }
}
// Part 03 - END

// Part 04 - Unconstrained Generic Type Definitions
typedef KeyValue<K, V> = MapEntry<K, V>;
// Part 04 - END

// Part 05 - Specializing Generic Type Definitions
typedef JSON<T> = Map<String, T>;
// Part 05 - END

// Part 06 - Generic Mixins and Specialized Mixin Type Definitions
mixin HasHeight<H extends num> {
  H get height;
}

typedef HasIntHeight = HasHeight<int>;
typedef HasDoubleHeight = HasHeight<double>;

class Person2 with HasDoubleHeight {
  @override
  final double height;
  const Person2({required this.height});
}

class Dog2 with HasIntHeight {
  @override
  final int height;

  const Dog2({required this.height});
}
// Part 06 - END

// Part 07 - Generic Classes with Generic Extensions
class Tuple<L, R> {
  final L left;
  final R right;
  const Tuple(this.left, this.right);

  @override
  String toString() => 'Tuple, left = $left, right = $right';
}

extension<L, R> on Tuple<L, R> {
  Tuple<R, L> swap() => Tuple(right, left);
}

extension<L extends num, R extends num> on Tuple<L, R> {
  num get sum => left + right;
}
// Part 07 - END

// Part 08 -  Generic Sorting with Comparable
const ages = [100, 20, 10, 90, 40];
const names = ['Foo', 'Bar', 'Baz'];
const distances = [3.1, 10.2, 1.3, 4.2];

int isLessThan<T extends Comparable>(T a, T b) => a.compareTo(b);
int isGreaterThan<T extends Comparable>(T a, T b) => b.compareTo(a);

void sort({required bool ascending}) {
  final comparator = ascending ? isLessThan : isGreaterThan;
  print([...ages]..sort(comparator));
  print([...names]..sort(comparator));
  print([...distances]..sort(comparator));
}
// Part 08 - END

// Part 09 - Handling Lack of Common Ancestors
extension ToInt on Object {
  int toInt() {
    final list = [
      if (this is Iterable<Object>)
        ...this as Iterable<Object>
      else if (this is int)
        [this as int]
      else
        (double.tryParse(toString()) ?? 0.0).round()
    ];
    return list
        .map(
          (e) => (double.tryParse(
                    e.toString(),
                  ) ??
                  0.0)
              .round(),
        )
        .reduce(
          (lhs, rhs) => lhs + rhs,
        );
  }
}
// Part 09 - END

// Part 10 - Generic Extension on Any Data Type

abstract class Thing {
  final String name;
  const Thing({required this.name});
}

class Person3 extends Thing {
  final int age;

  const Person3({
    required String name,
    required this.age,
  }) : super(name: name);
}

class Animal extends Thing {
  final String species;

  const Animal({
    required String name,
    required this.species,
  }) : super(name: name);
}

const Thing personThing = Person3(
  name: 'Foo',
  age: 20,
);

const Thing animalThing = Animal(
  name: 'Bar',
  species: 'Cat',
);

extension<T> on T {
  R? mapIfOfType<E, R>(R Function(E) f) {
    final shadow = this;
    if (shadow is E) {
      return f(shadow);
    } else {
      return null;
    }
  }
}
// Part 10 - END

// Part 11 - Generic Function Pointers

// Part 11 - END

// Part 12 - Generic Class Properties

// Part 13 - END
