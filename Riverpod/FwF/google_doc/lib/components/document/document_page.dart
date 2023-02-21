import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DocumentPage extends ConsumerWidget {
  const DocumentPage({
    required this.documentId,
    Key? key,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Text('Document $documentId'),
    );
  }
}
