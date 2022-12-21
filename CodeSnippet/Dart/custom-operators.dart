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
