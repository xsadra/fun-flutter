import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../lib.dart'
    show Post, userInfoModelProvider, SmallErrorAnimationView, RichTwoPartsText;

class PostDisplayNameAndMessageView extends ConsumerWidget {
  const PostDisplayNameAndMessageView({
    super.key,
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfoModel = ref.watch(userInfoModelProvider(post.userId));

    return userInfoModel.when(
      data: (userInfo) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichTwoPartsText(
          leftPart: userInfo.displayName,
          rightPart: post.message,
        ),
      ),
      error: (error, stackTrace) => const SmallErrorAnimationView(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
