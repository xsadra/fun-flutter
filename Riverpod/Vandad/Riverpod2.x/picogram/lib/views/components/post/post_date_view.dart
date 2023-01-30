import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostDateView extends StatelessWidget {
  const PostDateView({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat('d MMMM, yyyy - H:mm');
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(formatter.format(date)),
    );
  }
}
