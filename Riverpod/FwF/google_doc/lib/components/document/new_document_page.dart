import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';

class NewDocumentPage extends ConsumerStatefulWidget {
  const NewDocumentPage({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _NewDocumentPageState();
}

class _NewDocumentPageState extends ConsumerState<NewDocumentPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          ref.read(AppState.auth.notifier).signOut();
        },
        child: const Text('Sign out'),
      )
    );
  }
}
