import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../lib.dart' show Post, PostDetailsView, PostThumbnailView;

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
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PostDetailsView(post: post),
              ),
            );
            log('Post tapped: ${post.postId}', name: 'PostGridView');
          },
        );
      },
    );
  }
}
