import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../lib.dart'
    show
        Comment,
        userInfoModelProvider,
        RichTwoPartsText,
        SmallErrorAnimationView;

class CompactCommentTile extends ConsumerWidget {
  const CompactCommentTile({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfo = ref.watch(userInfoModelProvider(comment.fromUserId));

    return userInfo.when(
      data: (userInfo) {
        return RichTwoPartsText(
          leftPart: userInfo.displayName,
          rightPart: comment.comment,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const SmallErrorAnimationView(),
    );
  }
}
