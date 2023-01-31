import 'package:flutter/material.dart';

import '../../../lib.dart' show Comment, CompactCommentTile;

class CompactCommentColumn extends StatelessWidget {
  const CompactCommentColumn({
    super.key,
    required this.comments,
  });

  final Iterable<Comment> comments;

  @override
  Widget build(BuildContext context) {
    if (comments.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(
        left: 8.0,
        right: 8.0,
        bottom: 8.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final comment in comments)
            CompactCommentTile(
              key: ValueKey(comment.id),
              comment: comment,
            ),
        ],
      ),
    );
  }
}
