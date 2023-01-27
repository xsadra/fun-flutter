import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../state/state.dart';
import '../../views/views.dart';

class CreateNewPostView extends ConsumerStatefulWidget {
  const CreateNewPostView({
    required this.file,
    required this.fileType,
    Key? key,
  }) : super(key: key);

  final File file;
  final FileType fileType;

  @override
  ConsumerState createState() => _CreateNewPostViewState();
}

class _CreateNewPostViewState extends ConsumerState<CreateNewPostView> {
  @override
  Widget build(BuildContext context) {
    final thumbnailRequest = ThumbnailRequest(
      file: widget.file,
      fileType: widget.fileType,
    );

    final postSettings = ref.watch(postSettingProvider);

    final postController = useTextEditingController();

    final isPostButtonEnabled = useState(false);
    useEffect(() {
      void listener() {
        isPostButtonEnabled.value = postController.text.isNotEmpty;
      }

      postController.addListener(listener);
      return () => postController.removeListener(listener);
    }, [postController]);

    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.createNewPost),
        actions: [
          IconButton(
            onPressed: isPostButtonEnabled.value
                ? () async {
                    final userId = ref.read(userIdProvider);
                    if (userId == null) {
                      return;
                    }
                    final imageUploadNotifier =
                        ref.read(imageUploadProvider.notifier);
                    final isUploaded = await imageUploadNotifier.upload(
                      file: widget.file,
                      fileType: widget.fileType,
                      message: postController.text,
                      postSettings: postSettings,
                      userId: userId,
                    );
                    if (isUploaded && mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                : null,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            FileThumbnailView(
              thumbnailRequest: thumbnailRequest,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: postController,
                decoration: const InputDecoration(
                    hintText: Strings.pleaseWriteYourMessageHere),
                autofocus: true,
                maxLines: null,
              ),
            ),
            ...PostSetting.values.map(
              (setting) => ListTile(
                title: Text(setting.title),
                subtitle: Text(setting.description),
                leading: Switch(
                  value: postSettings[setting] ?? false,
                  onChanged: (isOn) {
                    ref
                        .read(postSettingProvider.notifier)
                        .setSetting(setting, isOn);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
