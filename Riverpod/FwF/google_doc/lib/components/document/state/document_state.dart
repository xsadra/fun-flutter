import 'package:flutter_quill/flutter_quill.dart';

import '../../../models/app_error.dart';
import '../../../models/models.dart';
import '../../controller_state_base.dart';

class DocumentState extends ControllerStateBase {
  const DocumentState({
    required this.id,
    this.documentPageData,
    this.document,
    this.controller,
    this.isSavedRemotely = false,
    AppError? error,
  }) : super(error: error);

  final String id;
  final DocumentPageData? documentPageData;
  final Document? document;
  final QuillController? controller;
  final bool isSavedRemotely;

  @override
  List<Object?> get props => [id, error];

  @override
  DocumentState copyWith({
    String? id,
    DocumentPageData? documentPageData,
    Document? document,
    QuillController? controller,
    bool? isSavedRemotely,
    AppError? error,
  }) {
    return DocumentState(
      id: id ?? this.id,
      documentPageData: documentPageData ?? this.documentPageData,
      document: document ?? this.document,
      controller: controller ?? this.controller,
      isSavedRemotely: isSavedRemotely ?? this.isSavedRemotely,
      error: error ?? this.error,
    );
  }
}
