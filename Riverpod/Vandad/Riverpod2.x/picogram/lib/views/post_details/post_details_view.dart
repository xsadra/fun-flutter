import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:share_plus/share_plus.dart';

import '../../lib.dart'
    show
        canCurrentUserDeletePostProvider,
        CompactCommentColumn,
        DeleteDialog,
        deletePostProvider,
        ErrorAnimationView,
        LikeButton,
        LikeCountView,
        LoadingAnimationView,
        Post,
        PostCommentsView,
        PostDateView,
        PostDisplayNameAndMessageView,
        PostMediaView,
        PostWithComments,
        Present,
        RequestForPostAndComment,
        SmallErrorAnimationView,
        specificPostWithCommentsProvider,
        SortOrder,
        Strings;

class PostDetailsView extends ConsumerStatefulWidget {
  const PostDetailsView({
    Key? key,
    required this.post,
  }) : super(key: key);

  final Post post;

  @override
  ConsumerState createState() => _PostDetailsViewState();
}

class _PostDetailsViewState extends ConsumerState<PostDetailsView> {
  @override
  Widget build(BuildContext context) {
    final request = RequestForPostAndComment(
      postId: widget.post.postId,
      limit: 5,
      sortByCreatedAt: true,
      sortOrder: SortOrder.oldOnTop,
    );

    final postWithComments = ref.watch(
      specificPostWithCommentsProvider(request),
    );

    final canDeletePost = ref.watch(
      canCurrentUserDeletePostProvider(widget.post),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.postDetails),
        actions: [
          _buildShareButton(postWithComments),
          if (canDeletePost.value ?? false)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: _deletePost,
            ),
        ],
      ),
      body: postWithComments.when(
        data: (post) {
          final postId = post.post.postId;
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PostMediaView(
                  post: post.post,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (post.post.allowLikes) _buildLikeButton(postId),
                    if (post.post.allowComments)
                      _buildCommentButton(context, postId),
                  ],
                ),
                PostDisplayNameAndMessageView(post: post.post),
                PostDateView(date: post.post.createdAt),
                _buildDivider(),
                CompactCommentColumn(comments: post.comments),
                if (post.post.allowLikes) _buildLikesCountView(postId),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
        loading: () => const LoadingAnimationView(),
        error: (error, stackTrace) => const ErrorAnimationView(),
      ),
    );
  }

  Widget _buildDivider() => const Padding(
        padding: EdgeInsets.all(8.0),
        child: Divider(color: Colors.white70),
      );

  Widget _buildLikesCountView(
    String postId,
  ) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            LikeCountView(postId: postId),
          ],
        ),
      );

  Widget _buildCommentButton(
    BuildContext context,
    String postId,
  ) =>
      IconButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => PostCommentsView(
                postId: postId,
              ),
            ),
          );
        },
        icon: const Icon(Icons.mode_comment_outlined),
      );

  Widget _buildLikeButton(
    String postId,
  ) =>
      LikeButton(postId: postId);

  Widget _buildShareButton(
    AsyncValue<PostWithComments> postWithComments,
  ) =>
      postWithComments.when(
        data: (data) => IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            final url = data.post.fileUrl;
            Share.share(
              url,
              subject: Strings.checkOutThisPost,
            );
          },
        ),
        error: (_, __) => const SmallErrorAnimationView(),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      );

  void _deletePost() async {
    final shouldDeletePost = await const DeleteDialog(
      titleOfObjectToDelete: Strings.post,
    ).present(context).then(
          (deleting) => deleting ?? false,
          onError: (_) => false,
        );
    if (shouldDeletePost) {
      await ref
          .read(
            deletePostProvider.notifier,
          )
          .deletePost(post: widget.post);
      if (mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
