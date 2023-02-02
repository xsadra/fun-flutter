import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../lib.dart'
    show
        Strings,
        EmptyContentsWithTextAnimationView,
        DataNotFoundAnimationView,
        ErrorAnimationView,
        PostGridView,
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
      return const EmptyContentsWithTextAnimationView(
        text: Strings.enterYourSearchTerm,
      );
    }
    final posts = ref.watch(postBySearchTermProvider(searchTerm));
    return posts.when(
      data: (posts) {
        if (posts.isEmpty) {
          return const DataNotFoundAnimationView();
        }
        return PostGridView(posts: posts);
      },
      error: (_, __) => const ErrorAnimationView(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
