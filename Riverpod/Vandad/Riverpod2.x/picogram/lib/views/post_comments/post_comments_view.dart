import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart'
    show useEffect, useState, useTextEditingController;
import 'package:hooks_riverpod/hooks_riverpod.dart'
    show AsyncValueX, HookConsumerWidget, WidgetRef;

import '../../lib.dart'
    show
        Comment,
        CommentTile,
        DismissKeyboard,
        EmptyContentsWithTextAnimationView,
        ErrorAnimationView,
        LoadingAnimationView,
        PostId,
        RequestForPostAndComment,
        Strings,
        postCommentProvider,
        sendCommentProvider,
        userIdProvider;

class PostCommentsView extends HookConsumerWidget {
  const PostCommentsView({
    required this.postId,
    Key? key,
  }) : super(key: key);

  final PostId postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final commentController = useTextEditingController();
    final hasComment = useState(false);
    final request = useState(RequestForPostAndComment(postId: postId));
    final comments = ref.watch(postCommentProvider(request.value));

    useEffect(() {
      commentController.addListener(() {
        hasComment.value = commentController.text.isNotEmpty;
      });
      return () {};
    }, [commentController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.comments),
        actions: [
          _buildSendButton(hasComment.value, commentController, ref),
        ],
      ),
      body: SafeArea(
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 4,
              child: comments.when(
                data: (comments) => comments.isEmpty
                    ? _buildNoCommentYetView()
                    : _buildCommentListView(ref, request, comments),
                error: (_, __) => const ErrorAnimationView(),
                loading: () => const LoadingAnimationView(),
              ),
            ),
            _buildCommentInput(commentController, ref),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton(
    bool isEnable,
    TextEditingController commentController,
    WidgetRef ref,
  ) =>
      IconButton(
        icon: const Icon(Icons.send),
        onPressed: isEnable
            ? () async {
                _submitCommentWithController(commentController, ref);
              }
            : null,
      );

  Widget _buildCommentListView(
    WidgetRef ref,
    ValueNotifier<RequestForPostAndComment> request,
    Iterable<Comment> comments,
  ) =>
      RefreshIndicator(
        onRefresh: () {
          ref.invalidate(postCommentProvider(request.value));
          return Future.delayed(const Duration(seconds: 1));
        },
        child: ListView.builder(
          itemCount: comments.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (context, index) {
            final comment = comments.elementAt(index);
            return CommentTile(comment: comment);
          },
        ),
      );

  Widget _buildNoCommentYetView() => const SingleChildScrollView(
        child: EmptyContentsWithTextAnimationView(
          text: Strings.noCommentsYet,
        ),
      );

  Widget _buildCommentInput(
    TextEditingController commentController,
    WidgetRef ref,
  ) =>
      Expanded(
        flex: 1,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
              textInputAction: TextInputAction.send,
              controller: commentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: Strings.writeYourCommentHere,
              ),
              onSubmitted: (comment) async {
                _submitCommentWithController(commentController, ref);
              },
            ),
          ),
        ),
      );

  Future<void> _submitCommentWithController(
    TextEditingController controller,
    WidgetRef ref,
  ) async {
    final comment = controller.text;
    if (comment.isEmpty) {
      return;
    }
    final userId = ref.read(userIdProvider);
    if (userId == null) {
      return;
    }
    final isSend = await ref.read(sendCommentProvider.notifier).sendComment(
          fromUserId: userId,
          onPostId: postId,
          comment: comment,
        );
    if (isSend) {
      controller.clear();
      dismissKeyboard();
    }
  }
}
