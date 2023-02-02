import 'dart:developer' show log;

import 'package:flutter/material.dart';

import '../../../lib.dart' show Post, PostDetailsView, PostThumbnailView;

class PostSliverGridView extends StatelessWidget {
  const PostSliverGridView({
    super.key,
    required this.posts,
  });

  final Iterable<Post> posts;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      delegate: SliverChildBuilderDelegate((context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTapped: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostDetailsView(post: post),
              ),
            );
            log('Post tapped: ${post.postId}', name: 'PostSliverGridView  ');
          },
        );
      }, childCount: posts.length),
    );
  }
}
