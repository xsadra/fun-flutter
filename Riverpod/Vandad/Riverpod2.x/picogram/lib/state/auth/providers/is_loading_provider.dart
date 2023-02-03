import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../state.dart'
    show
        authStateProvider,
        deletePostProvider,
        imageUploadProvider,
        sendCommentProvider,
        deleteCommentProvider;

part 'is_loading_provider.g.dart';

@riverpod
bool isLoading(IsLoadingRef ref) {
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
}
