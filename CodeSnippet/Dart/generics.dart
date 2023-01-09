// Generics
void main(List<String> args) {
// Part 01 - Generic Integer or Double
  final double doubleValue = eitherIntOrDouble();
  print(doubleValue);
  final int intValue = eitherIntOrDouble();
  print(intValue);

// Part 02 - Type Matching

// Part 03 - Constrained Generic Type Definitions

// Part 04 - Unconstrained Generic Type Definitions

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

// Part 02 - END

// Part 03 - Constrained Generic Type Definitions

// Part 03 - END

// Part 04 - Unconstrained Generic Type Definitions

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
