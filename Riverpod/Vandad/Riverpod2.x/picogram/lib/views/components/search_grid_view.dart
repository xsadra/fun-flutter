import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:picogram/views/components/post/post_sliver_grid_view.dart';

import '../../lib.dart'
    show
        Strings,
        EmptyContentsWithTextAnimationView,
        DataNotFoundAnimationView,
        ErrorAnimationView,
        postBySearchTermProvider,
        SearchTerm;

class SearchGridView extends ConsumerWidget {
  const SearchGridView({
    Key? key,
    required this.searchTerm,
  }) : super(key: key);

  final SearchTerm searchTerm;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (searchTerm.isEmpty) {
      return const SliverToBoxAdapter(
        child: EmptyContentsWithTextAnimationView(
          text: Strings.enterYourSearchTerm,
        ),
      );
    }
    final posts = ref.watch(postBySearchTermProvider(searchTerm));
    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const SliverToBoxAdapter(
            child: DataNotFoundAnimationView(),
          );
        }
        return PostSliverGridView(posts: posts);
      },
      error: (_, __) => const SliverToBoxAdapter(
        child: ErrorAnimationView(),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
