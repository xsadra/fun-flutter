import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

import '../../app/navigation/routes.dart';
import '../../app/providers.dart';
import '../../repositories/repositories.dart';

class NewDocumentPage extends ConsumerStatefulWidget {
  const NewDocumentPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _NewDocumentPageState();
}

class _NewDocumentPageState extends ConsumerState<NewDocumentPage> {
  final _uuid = const Uuid();
  bool showErrorMessage = false;

  @override
  void initState() {
    super.initState();
    _createDocument();
  }

  Future<void> _createDocument() async {
    final id = _uuid.v4();

    try {
      await ref.read(Repository.database).createNewPage(
            documentId: id,
            owner: ref.read(AppState.auth).account?.$id ?? '',
          );
      if (!mounted) return;
      Routemaster.of(context).push('${AppRoutes.document}/$id');
    } on RepositoryException catch (_) {
      setState(() {
        showErrorMessage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return showErrorMessage
        ? const Center(
            child: Text('An error occurred!'),
          )
        : Center(
            child: TextButton(
              onPressed: () {
                ref.read(AppState.auth.notifier).signOut();
              },
              child: const Text('Sign out'),
            ),
          );
  }
}
