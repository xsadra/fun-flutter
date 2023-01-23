import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:picogram/views/views.dart';

import '../../../state/posts/posts.dart';

typedef EmptyWithText = EmptyContentsWithTextAnimationView;

class UserPostsView extends ConsumerWidget {
  const UserPostsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(userPostProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(userPostProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(
        data: (posts) => posts.isEmpty
            ? const EmptyWithText(text: Strings.youHaveNoPosts)
            : PostGridView(posts: posts),
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}
