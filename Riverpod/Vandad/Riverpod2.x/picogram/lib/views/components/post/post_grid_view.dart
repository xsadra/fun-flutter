import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../state/posts/posts.dart';
import 'post.dart';

class PostGridView extends StatelessWidget {
  const PostGridView({
    Key? key,
    required this.posts,
  }) : super(key: key);

  final Iterable<Post> posts;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      ),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts.elementAt(index);
        return PostThumbnailView(
          post: post,
          onTapped: () {
            // Todo: Navigate to PostView
            log('Post tapped: ${post.postId}', name: 'PostGridView');
          },
        );
      },
    );
  }
}
