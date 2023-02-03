import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'
    show FontAwesomeIcons, FaIcon;
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/state.dart'
    show
        PostId,
        likeDislikePostProvider,
        userIdProvider,
        LikeDislikeRequest,
        hasLikedPostProvider;
import '../../views/views.dart' show SmallErrorAnimationView;

class LikeButton extends ConsumerWidget {
  const LikeButton({
    super.key,
    required this.postId,
  });

  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasLiked = ref.watch(hasLikedPostProvider(postId));
    return hasLiked.when(
      data: (hasLike) {
        return IconButton(
          icon: FaIcon(
            // hasLike ? Icons.favorite : Icons.favorite_border,
            hasLike ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
            color: hasLike ? Colors.red :null,
          ),
          onPressed: () {
            final userId = ref.read(userIdProvider);
            if (userId == null) {
              return;
            }
            ref.read(
              likeDislikePostProvider(
                request: LikeDislikeRequest(postId: postId, userId: userId),
              ),
            );
          },
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (_, __) => const SmallErrorAnimationView(),
    );
  }
}
