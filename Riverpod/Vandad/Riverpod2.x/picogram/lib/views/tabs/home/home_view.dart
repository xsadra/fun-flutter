import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../lib.dart'
    show
        EmptyContentsWithTextAnimationView,
        ErrorAnimationView,
        LoadingAnimationView,
        PostGridView,
        Strings,
        allPostsProvider;

class HomeView extends ConsumerWidget {
  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(allPostsProvider);

    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allPostsProvider);
        return Future.delayed(const Duration(seconds: 1));
      },
      child: posts.when(
        data: (posts) {
          if (posts.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.noPostsAvailable,
            );
          }
          return PostGridView(posts: posts);
        },
        loading: () => const LoadingAnimationView(),
        error: (error, stack) => const ErrorAnimationView(),
      ),
    );
  }
}
