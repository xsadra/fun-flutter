import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart' show IsLoading, ImageUploadNotifier;

final imageUploadProvider =
    StateNotifierProvider<ImageUploadNotifier, IsLoading>(
  (ref) => ImageUploadNotifier(),
);