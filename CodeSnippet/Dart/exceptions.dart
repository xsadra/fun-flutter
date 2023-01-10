// Exceptions and Errors
void main(List<String> args) {
  // Part 01 - Throwing in Class Constructors
  tryCreatingPerson(age: 20);
  tryCreatingPerson(age: -1);
  tryCreatingPerson(age: 141);

  // Part 02 - Custom Exception Class

  // Part 03 - Rethrow

  // Part 04 - Finally

  // Part 05 - Custom Throws Annotation

  // Part 06 - Throwing Errors

  // Part 07 - Capturing Stack Trace
}

// Part 01 - Throwing in Class Constructors
void tryCreatingPerson({int age = 0}) {
  try {
    print(Person(age: age).age);
  } catch (e) {
    print(e.runtimeType);
    print(e);
  }
  print('--------------------');
}

class Person {
  final int age;

  Person({
    required this.age,
  }) {
    if (age < 0) {
      throw Exception('Age must be positive');
    } else if (age > 140) {
      throw 'Age must be less than 140';
    }
  }
}
// Part 01 - END
// Part 02 - Custom Exception Class
// Part 02 - END
// Part 03 - Rethrow
// Part 03 - END
// Part 04 - Finally
// Part 04 - END
// Part 05 - Custom Throws Annotation
// Part 05 - END
// Part 06 - Throwing Errors
// Part 06 - END
// Part 07 - Capturing Stack Trace
// Part 07 - END
