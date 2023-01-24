import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;

import 'file_type.dart';

@immutable
class ThumbnailRequest {
  const ThumbnailRequest({
    required this.file,
    required this.fileType,
  });

  final File file;
  final FileType fileType;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThumbnailRequest &&
          runtimeType == other.runtimeType &&
          file == other.file &&
          fileType == other.fileType;

  @override
  int get hashCode => file.hashCode ^ fileType.hashCode;
}
