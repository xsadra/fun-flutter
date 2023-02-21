import 'package:flutter/painting.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'document_state.dart';

final _documentProvider =
    StateNotifierProvider.family<DocumentController, DocumentState, String>(
  (ref, documentId) => DocumentController(
    ref,
    documentId: documentId,
  ),
);

class DocumentController extends StateNotifier<DocumentState> {
  DocumentController(this._ref, {required String documentId})
      : super(
          DocumentState(id: documentId),
        ) {
     _setupDocument();
  }

  final Ref _ref;

  static StateNotifierProviderFamily<DocumentController, DocumentState, String>
      get provider => _documentProvider;

  static AlwaysAliveRefreshable<DocumentController> notifier(
          String documentId) =>
      provider(documentId).notifier;


  Future<void> _setupDocument() async {
    final quillDocument = Document()..insert(0, '');
    final controller = QuillController(
      document: quillDocument,
      selection: const TextSelection.collapsed(offset: 0),
    );

    state = state.copyWith(
      document: quillDocument,
      controller: controller,
    );
  }
}
