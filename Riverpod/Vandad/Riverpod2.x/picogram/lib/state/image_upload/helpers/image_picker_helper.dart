import 'dart:io';

import 'package:flutter/foundation.dart' show immutable;
import 'package:image_picker/image_picker.dart';

import '../../state.dart';

@immutable
class ImagePickerHelper {
  static final ImagePicker _singleton = ImagePicker();

  static Future<File?> pickImage() =>
      _singleton.pickImage(source: ImageSource.gallery).toFile();

  static Future<File?> pickVideo() =>
      _singleton.pickVideo(source: ImageSource.gallery).toFile();
}
