import 'package:example5/providers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'create_update_dialog.dart';

class HomePage extends ConsumerWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Consumer(
        builder: (context, ref, child) {
          final dataModel = ref.watch(peopleProvider);
          return ListView.builder(
            itemCount: dataModel.count,
            itemBuilder: (context, index) {
              final person = dataModel.people.elementAt(index);
              return Dismissible(
                key: Key(person.uuid),
                onDismissed: (direction) => dataModel.removePerson(person),
                direction: DismissDirection.endToStart,
                background: const Icon(
                  Icons.delete_forever,
                  color: Colors.red,
                ),
                child: ListTile(
                  title: GestureDetector(
                      onTap: () async {
                        final updatedPerson = await createUpdatePersonDialog(
                          context,
                          person,
                        );
                        if (updatedPerson != null) {
                          dataModel.updatePerson(updatedPerson);
                        }
                      },
                      child: Text(person.displayName)),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final person = await createUpdatePersonDialog(context);
          if (person != null) {
            final dataModel = ref.read(peopleProvider);
            dataModel.addPerson(person);
          }
        },
        child: const Icon(Icons.person_add),
      ),
    );
  }
}
