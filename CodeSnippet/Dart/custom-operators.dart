// CustomOperators
void main(List<String> args) {
// Part 01 - Add to Same class together
  final me = FamilyMember(name: 'Sadra');
  final you = FamilyMember(name: 'Sara');
  final family = me + you;
  print(family);
  // Part 01 - END
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