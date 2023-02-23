import 'dart:async';

import 'package:flutter/painting.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../app/providers.dart';
import '../../../core/log/logger.dart';
import '../../../models/app_error.dart';
import '../../../repositories/repository_exception.dart';
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
  Timer? _debounce;

  static StateNotifierProviderFamily<DocumentController, DocumentState, String>
      get provider => _documentProvider;

  static AlwaysAliveRefreshable<DocumentController> notifier(
          String documentId) =>
      provider(documentId).notifier;



  Future<void> _setupDocument() async {
    try {
      final docPageData = await _ref.read(Repository.database).getPage(
        documentId: state.id,
      );

      late final Document quillDoc;
      if (docPageData.content.isEmpty) {
        quillDoc = Document()..insert(0, '');
      } else {
        quillDoc = Document.fromDelta(docPageData.content);
      }

      final controller = QuillController(
        document: quillDoc,
        selection: const TextSelection.collapsed(offset: 0),
      );

      state = state.copyWith(
        documentPageData: docPageData,
        document: quillDoc,
        controller: controller,
        isSavedRemotely: true,
      );

      state.controller?.addListener(_quillControllerUpdate);
    } on RepositoryException catch (e) {
      state = state.copyWith(error: AppError(message: e.message));
    }
  }

  void _quillControllerUpdate() {
    state = state.copyWith(isSavedRemotely: false);
    _debounceSave();
  }

  void _debounceSave({Duration duration = const Duration(seconds: 2)}) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(duration, () {
      saveDocumentImmediately();
    });
  }

  void setTitle(String title) {
    state = state.copyWith(
      documentPageData: state.documentPageData?.copyWith(
        title: title,
      ),
      isSavedRemotely: false,
    );
    _debounceSave(duration: const Duration(milliseconds: 500));
  }

  Future<void> saveDocumentImmediately() async {
    logger.info('Saving document: ${state.id}');
    if (state.documentPageData == null || state.document == null) {
      logger.severe('Cannot save document, doc state is empty');
      state = state.copyWith(
        error: AppError(message: 'Cannot save document, state is empty'),
      );
    }
    state = state.copyWith(
      documentPageData: state.documentPageData!
          .copyWith(content: state.document!.toDelta()),
    );
    try {
      await _ref.read(Repository.database).updatePage(
        documentId: state.id,
        data: state.documentPageData!,
      );
      state = state.copyWith(isSavedRemotely: true);
    } on RepositoryException catch (e) {
      state = state.copyWith(
        error: AppError(message: e.message),
        isSavedRemotely: false,
      );
    }
  }

  @override
  void dispose() {
    state.controller?.removeListener(_quillControllerUpdate);
    super.dispose();
  }
}
