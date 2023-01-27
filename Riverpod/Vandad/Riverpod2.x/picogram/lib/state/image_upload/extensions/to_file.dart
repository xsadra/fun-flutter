import 'dart:io';

import 'package:image_picker/image_picker.dart';

extension ToFile on Future<XFile?> {
  Future<File?> toFile() => then(
        (xFile) => xFile?.path,
      ).then(
        (path) => path == null ? null : File(path),
      );
}
