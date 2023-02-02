import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state.dart'
    show
        authStateProvider,
        deletePostProvider,
        imageUploadProvider,
        sendCommentProvider,
        deleteCommentProvider;

final isLoadingProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);

  return authState.isLoading ||
      isUploadingImage ||
      isSendingComment ||
      isDeletingPost ||
      isDeletingComment;
});
