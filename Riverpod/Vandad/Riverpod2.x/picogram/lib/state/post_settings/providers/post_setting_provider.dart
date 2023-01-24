import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../post_settings.dart';

final postSettingProvider =
    StateNotifierProvider<PostSettingNotifier, PostSettingState>((ref) {
  return PostSettingNotifier();
});
