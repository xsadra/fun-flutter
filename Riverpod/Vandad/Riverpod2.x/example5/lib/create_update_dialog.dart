import 'package:example5/person.dart';
import 'package:flutter/material.dart';

final nameController = TextEditingController();
final ageController = TextEditingController();

Future<Person?> createUpdatePersonDialog(
  BuildContext context, [
  Person? existingPerson,
]) {
  String? name = existingPerson?.name;
  int? age = existingPerson?.age;

  nameController.text = name ?? '';
  ageController.text = age?.toString() ?? '';

  return showDialog(
    context: context,
    builder: (context) {
      final title =
          existingPerson == null ? 'Create a Person' : 'Update the Person';
      return AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Enter name here'),
              onChanged: (value) => name = value,
            ),
            TextField(
              controller: ageController,
              decoration: const InputDecoration(labelText: 'Enter age here'),
              onChanged: (value) => age = int.tryParse(value),
            ),
          ],
        ),
        actions: [
          const CancelButton(),
          TextButton(
            onPressed: () {
              if (name != null && age != null) {
                if (existingPerson != null) {
                  final newPerson =
                      existingPerson.copyWith(name: name, age: age);
                  Navigator.of(context).pop(newPerson);
                } else {
                  Navigator.of(context).pop(
                    Person(name: name!, age: age!),
                  );
                }
              } else {
                Navigator.of(context).pop();
              }
            },
            child: const Text('Cave'),
          ),
        ],
      );
    },
  );
}

class CancelButton extends StatelessWidget {
  const CancelButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    );
  }
}
