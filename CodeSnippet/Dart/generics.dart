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

// Part 06 - Generic Mixins and Specialized Mixin Type Definitions

// Part 07 - Generic Classes with Generic Extensions

// Part 08 -  Generic Sorting with Comparable

// Part 09 - Handling Lack of Common Ancestors

// Part 10 - Generic Extension on Any Data Type

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

// Part 05 - END

// Part 06 - Generic Mixins and Specialized Mixin Type Definitions

// Part 06 - END

// Part 07 - Generic Classes with Generic Extensions

// Part 07 - END

// Part 08 -  Generic Sorting with Comparable

// Part 08 - END

// Part 09 - Handling Lack of Common Ancestors

// Part 09 - END

// Part 10 - Generic Extension on Any Data Type

// Part 10 - END

// Part 11 - Generic Function Pointers

// Part 11 - END

// Part 12 - Generic Class Properties

// Part 13 - END
