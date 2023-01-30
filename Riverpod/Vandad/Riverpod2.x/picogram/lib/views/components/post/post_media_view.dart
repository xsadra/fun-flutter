import 'package:flutter/material.dart';

import '../../../lib.dart'
    show Post, FileType, PostImageView, PostVideoView, ErrorAnimationView;

class PostMediaView extends StatelessWidget {
  const PostMediaView({super.key, required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return () {
      switch (post.fileType) {
        case FileType.image:
          return PostImageView(post: post);
        case FileType.video:
          return PostVideoView(post: post);
        default:
          return const ErrorAnimationView();
      }
    }();
  }
}
