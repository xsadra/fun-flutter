// Exceptions and Errors
void main(List<String> args) async {
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
  try {
    print('Dog aged 11 is going to run...');
    Dog5(
      age: 11,
      isTired: false,
    ).run();
  } catch (e) {
    print(e);
  }

  try {
    print('A tired dog is going to run...');
    Dog5(
      age: 2,
      isTired: true,
    ).run();
  } catch (e) {
    print(e);
  }

  // Part 06 - Throwing Errors
  final person = Person6(age: 10);
  print(person);
  person.age = 0;
  print(person);

  try {
    /// errors are not created to be caught, so if you get an error
    /// make sure that you change your program in order to avoid that error
    /// exceptions however are meant to be caught
    person.age = -1;
    print(person);
  } catch (e) {
    print(e);
  } finally {
    print(person);
  }

  // Part 07 - Capturing Stack Trace
  Dog7(isTired: false).run();
  try {
    Dog7(isTired: true).run();
  } catch (e, stackTrace) {
    print(e);
    print(stackTrace);
  }
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
class Throws<T> {
  final List<T> exceptions;
  const Throws(this.exceptions);
}

class DogIsTooOldException implements Exception {
  const DogIsTooOldException();
}

class DogIsTiredException implements Exception {
  const DogIsTiredException();
}

class Animal {
  final int age;

  const Animal({
    required this.age,
  });

  @Throws([UnimplementedError])
  void run() => throw UnimplementedError();
}

class Dog5 extends Animal {
  final bool isTired;

  const Dog5({
    required super.age,
    required this.isTired,
  });

  @Throws([DogIsTooOldException, DogIsTiredException])

  /// This function throws the following exceptions:
  /// - [DogIsTooOldException] if the dog is older than 10 years old.
  /// - [DogIsTiredException] if the dog is tired.
  @override
  void run() {
    if (age > 10) {
      throw const DogIsTooOldException();
    } else if (isTired) {
      throw const DogIsTiredException();
    } else {
      print('Dog is running');
    }
  }
}
// Part 05 - END

// Part 06 - Throwing Errors
class Person6 {
  int _age;

  Person6({
    required int age,
  }) : _age = age;

  int get age => _age;

  set age(int value) {
    if (value < 0) {
      throw ArgumentError('Age cannot be negative.');
    }
    _age = value;
  }

  @override
  String toString() => 'Person(age: $age)';
}
// Part 06 - END

// Part 07 - Capturing Stack Trace
class DogIsTiredException7 implements Exception {
  final String message;
  DogIsTiredException7([this.message = 'Poor doggy is tired']);
}

class Dog7 {
  final bool isTired;

  const Dog7({
    required this.isTired,
  });

  void run() {
    if (isTired) {
      throw DogIsTiredException7('Poor doggo is tired');
    } else {
      print('Doggo is running');
    }
  }
}
// Part 07 - END
