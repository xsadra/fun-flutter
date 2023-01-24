import 'package:flutter/material.dart';

@immutable
class AlertDialogModel<T> {
  const AlertDialogModel({
    required this.title,
    required this.message,
    required this.actions,
  });

  final String title;
  final String message;
  final Map<String, T> actions;
}

extension Present<T> on AlertDialogModel<T> {
  Future<T?> present(BuildContext context) => showDialog<T>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: actions.entries
              .map(
                (entry) => TextButton(
                  child: Text(entry.key),
                  onPressed: () => Navigator.of(context).pop(entry.value),
                ),
              )
              .toList(),
        ),
      );
}
