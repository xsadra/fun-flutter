import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../lib.dart'
    show
        ComponentStrings,
        LoadingAnimationView,
        PostId,
        SmallErrorAnimationView,
        postLikesCountProvider;

class LikeCountView extends ConsumerWidget {
  const LikeCountView({super.key, required this.postId});

  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final likesCount = ref.watch(postLikesCountProvider(postId));
    return likesCount.when(
      data: (count) {
        final personOrPeople =
            count == 1 ? ComponentStrings.person : ComponentStrings.people;

        final likesText =
            '$count $personOrPeople ${ComponentStrings.likedThis}';
        return Text(likesText);
      },
      loading: () => const LoadingAnimationView(),
      error: (error, stack) => const SmallErrorAnimationView(),
    );
  }
}
