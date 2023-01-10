// Exceptions and Errors
void main(List<String> args) {
  // Part 01 - Throwing in Class Constructors
  tryCreatingPerson(age: 20);
  tryCreatingPerson(age: -1);
  tryCreatingPerson(age: 141);

  // Part 02 - Custom Exception Class
  tryCreatingPerson2(age: 20);
  tryCreatingPerson2(age: -1);
  tryCreatingPerson2(age: 141);

  // Part 03 - Rethrow
  try {
    tryCreatingPerson3(age: 20);
    tryCreatingPerson3(age: -1);
    tryCreatingPerson3(age: 141);
  } catch (error, stackTrace) {
    print(error);
    print(stackTrace);
  }

  // Part 04 - Finally
  final db = Database();
  try {
    await db.getData();
  } on DatabaseNotOpenException {
    print('We forgot to open the database');
  } finally {
    await db.close();
  }

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
void tryCreatingPerson2({int age = 0}) {
  try {
    print(Person2(age: age).age);
  } on InvalidAgeException catch (exception, strackTrace) {
    print(exception);
    print(strackTrace);
  }
  print('--------------------');
}

class InvalidAgeException implements Exception {
  final int age;
  final String message;

  InvalidAgeException(this.age, this.message);

  @override
  String toString() => 'InvalidAgeException, $message, $age';
}

class Person2 {
  final int age;

  Person2({
    required this.age,
  }) {
    if (age < 0) {
      throw InvalidAgeException(
        age,
        'Age cannot be negative',
      );
    } else if (age > 140) {
      throw InvalidAgeException(
        age,
        'Age cannot be greater than 140',
      );
    }
  }
}
// Part 02 - END

// Part 03 - Rethrow
void tryCreatingPerson3({int age = 0}) {
  try {
    print(Person3(age: age).age);
  } on InvalidAgeException3 {
    rethrow;
  }
  print('--------------------');
}

class InvalidAgeException3 implements Exception {
  final int age;
  final String message;

  InvalidAgeException3(this.age, this.message);

  @override
  String toString() => 'InvalidAgeException, $message. Age = $age';
}

class Person3 {
  final int age;

  Person3({required this.age}) {
    if (age < 0) {
      throw InvalidAgeException3(age, 'Age cannot be negative');
    }
    if (age > 140) {
      throw InvalidAgeException3(age, 'Age cannot be greater than 140');
    }
  }
}
// Part 03 - END

// Part 04 - Finally
class Database {
  bool _isDbOpen = false;

  Future<void> open() {
    return Future.delayed(Duration(seconds: 1), () {
      _isDbOpen = true;
      print('Database opened');
    });
  }

  Future<String> getData() {
    if (!_isDbOpen) {
      throw DatabaseNotOpenException();
    }
    return Future.delayed(
      Duration(seconds: 1),
      () => 'Data',
    );
  }

  Future<void> close() {
    return Future.delayed(Duration(seconds: 1), () {
      _isDbOpen = false;
      print('Database closed');
    });
  }
}

class DatabaseNotOpenException implements Exception {
  @override
  String toString() => 'DatabaseNotOpenException';
}
// Part 04 - END

// Part 05 - Custom Throws Annotation
// Part 05 - END

// Part 06 - Throwing Errors
// Part 06 - END

// Part 07 - Capturing Stack Trace
// Part 07 - END
