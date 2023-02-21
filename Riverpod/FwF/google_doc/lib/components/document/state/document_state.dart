import 'package:flutter_quill/flutter_quill.dart';

import '../../../models/app_error.dart';
import '../../controller_state_base.dart';

class DocumentState extends ControllerStateBase {
  const DocumentState({
    required this.id,
    this.document,
    this.controller,
    AppError? error,
  }) : super(error: error);

  final String id;
  final Document? document;
  final QuillController? controller;

  @override
  List<Object?> get props => [id, error];

  @override
  DocumentState copyWith({
    String? id,
    Document? document,
    QuillController? controller,
    AppError? error,
  }) {
    return DocumentState(
      id: id ?? this.id,
      document: document ?? this.document,
      controller: controller ?? this.controller,
      error: error ?? this.error,
    );
  }
}
