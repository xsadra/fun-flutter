import 'package:flutter/material.dart';
import 'package:picogram/state/posts/posts.dart';

class PostThumbnailView extends StatelessWidget {
  const PostThumbnailView({
    Key? key,
    required this.post,
    required this.onTapped,
  }) : super(key: key);

  final Post post;
  final VoidCallback onTapped;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTapped,
      child: Image.network(
        post.thumbnailUrl,
        fit: BoxFit.cover,
      ),
    );
  }
}
