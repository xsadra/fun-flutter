import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/state/state.dart';
import '../../components/controller_state_base.dart';

extension RefX on WidgetRef {
  void errorStateListener(
    BuildContext context,
    ProviderListenable<StateBase> provider,
  ) {
    listen<StateBase>(provider, ((previous, next) {
      final message = next.error?.message;
      if (next.error != previous?.error &&
          message != null &&
          message.isNotEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    }));
  }

  void errorControllerStateListener(
    BuildContext context,
    ProviderListenable<ControllerStateBase> provider,
  ) {
    listen<ControllerStateBase>(provider, ((previous, next) {
      final message = next.error?.message;
      if (next.error != previous?.error &&
          message != null &&
          message.isNotEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(message)));
      }
    }));
  }
}
