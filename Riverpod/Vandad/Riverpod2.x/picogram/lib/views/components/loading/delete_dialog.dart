import 'package:flutter/foundation.dart' show immutable;

import '../components.dart';

@immutable
class DeleteDialog extends AlertDialogModel<bool> {
  const DeleteDialog({
    required String titleOfObjectToDelete,
  }) : super(
          title: '${ComponentStrings.delete} $titleOfObjectToDelete?',
          message:
              '${ComponentStrings.areYouSureYouWantToDeleteThis} $titleOfObjectToDelete?',
          actions: const {
            ComponentStrings.cancel: false,
            ComponentStrings.delete: true,
          },
        );
}
