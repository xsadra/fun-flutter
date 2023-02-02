import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../state/state.dart';
import '../../views.dart';

class CommentTile extends ConsumerWidget {
  const CommentTile({
    Key? key,
    required this.comment,
  }) : super(key: key);

  final Comment comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));
    return userInfo.when(
      data: (userInfo) {
        final currentUserId = ref.read(userIdProvider);
        return ListTile(
          trailing: currentUserId == comment.fromUserId
              ? IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    final shouldDelete = await displayDeleteDialog(context);
                    if (shouldDelete) {
                      await ref
                          .read(deleteCommentProvider.notifier)
                          .deleteComment(commentId: comment.id);
                    }
                  },
                )
              : null,
          title: Text(userInfo.displayName),
          subtitle: Text(comment.comment),
        );
      },
      loading: () => const LoadingAnimationView(),
      error: (_, __) => const SmallErrorAnimationView(),
    );
  }

  Future<bool> displayDeleteDialog(
    BuildContext context,
  ) =>
      const DeleteDialog(titleOfObjectToDelete: ComponentStrings.comment)
          .present(context)
          .then((value) => value ?? false);
}
