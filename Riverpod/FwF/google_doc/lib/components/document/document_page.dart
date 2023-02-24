import 'package:flutter/material.dart' hide MenuBar;
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tuple/tuple.dart';

import '../../app/app.dart';
import '../../app/navigation/routes.dart';
import '../../app/providers.dart';
import 'state/document_controller.dart';
import 'widgets/widgets.dart';

final _quillControllerProvider =
    Provider.family<QuillController?, String>((ref, id) {
  final test = ref.watch(DocumentController.provider(id));
  return test.controller;
});

class DocumentPage extends ConsumerWidget {
  const DocumentPage({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          MenuBar(
            leading: [TitleTextEditor(documentId: documentId)],
            trailing: [IsSavedIndicator(documentId: documentId)],
            newDocumentPressed: () {
              Routemaster.of(context).push(AppRoutes.newDocument);
            },
            signOutPressed: () {
              ref.read(AppState.auth.notifier).signOut();
            },
            openDocumentsPressed: () {
              Future.delayed(const Duration(milliseconds: 0), () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      child: ConstrainedBox(
                        constraints: BoxConstraints.loose(
                          const Size(1400, 700),
                        ),
                        child: const AllDocumentsPopup(),
                      ),
                    );
                  },
                );
              });
            },
          ),
          _Toolbar(documentId: documentId),
          Expanded(
            child: _DocumentEditorWidget(
              documentId: documentId,
            ),
          ),
        ],
      ),
    );
  }
}

final _documentTitleProvider = Provider.family<String?, String>((ref, id) {
  final provider = ref.watch(DocumentController.provider(id));
  return provider.documentPageData?.title;
});

class TitleTextEditor extends ConsumerStatefulWidget {
  const TitleTextEditor({
    required this.documentId,
    Key? key,
  }) : super(key: key);

  final String documentId;

  @override
  ConsumerState createState() => _TitleTextEditorState();
}

class _TitleTextEditorState extends ConsumerState<TitleTextEditor> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<String?>(
      _documentTitleProvider(widget.documentId),
      (previous, current) {
        if (current != _titleController.text) {
          _titleController.text = current ?? '';
        }
      },
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IntrinsicWidth(
        child: TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              hintText: 'Untitled Document',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 3,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 3,
                ),
              ),
            ),
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w400,
            ),
            onChanged: ref
                .read(DocumentController.notifier(widget.documentId))
                .setTitle),
      ),
    );
  }
}

final _isSavedRemotelyProvider = Provider.family<bool, String>((ref, id) {
  return ref.watch(DocumentController.provider(id)).isSavedRemotely;
});

class IsSavedIndicator extends ConsumerWidget {
  const IsSavedIndicator({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSaved = ref.watch(
      _isSavedRemotelyProvider(documentId),
    );

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: isSaved
          ? const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Changes saved',
                style: TextStyle(color: Colors.green),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}

class _DocumentEditorWidget extends ConsumerStatefulWidget {
  const _DocumentEditorWidget({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      __DocumentEditorState();
}

class __DocumentEditorState extends ConsumerState<_DocumentEditorWidget> {
  final FocusNode _focusNode = FocusNode();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final quillController =
        ref.watch(_quillControllerProvider(widget.documentId));

    if (quillController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          if (event.data.isControlPressed && event.character == 'b' ||
              event.data.isMetaPressed && event.character == 'b') {
            if (quillController
                .getSelectionStyle()
                .attributes
                .keys
                .contains('bold')) {
              quillController
                  .formatSelection(Attribute.clone(Attribute.bold, null));
            } else {
              quillController.formatSelection(Attribute.bold);
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Card(
            elevation: 7,
            child: Padding(
              padding: const EdgeInsets.all(86.0),
              child: QuillEditor(
                controller: quillController,
                scrollController: _scrollController,
                scrollable: true,
                focusNode: _focusNode,
                autoFocus: false,
                readOnly: false,
                expands: false,
                padding: EdgeInsets.zero,
                customStyles: DefaultStyles(
                  h1: DefaultTextBlockStyle(
                    const TextStyle(
                      fontSize: 36,
                      color: Colors.black,
                      height: 1.15,
                      fontWeight: FontWeight.w600,
                    ),
                    const Tuple2(32, 28),
                    const Tuple2(0, 0),
                    null,
                  ),
                  h2: DefaultTextBlockStyle(
                    const TextStyle(
                      fontSize: 30,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                    const Tuple2(28, 24),
                    const Tuple2(0, 0),
                    null,
                  ),
                  h3: DefaultTextBlockStyle(
                    TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w600,
                    ),
                    const Tuple2(18, 14),
                    const Tuple2(0, 0),
                    null,
                  ),
                  paragraph: DefaultTextBlockStyle(
                    const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    const Tuple2(2, 0),
                    const Tuple2(0, 0),
                    null,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

// Widget _defaultEmbedBuilderWeb(BuildContext context,
//     QuillController controller, Embed node, bool readOnly) {
//   throw UnimplementedError(
//     'Embeddable type "${node.value.type}" is not supported by default '
//         'embed builder of QuillEditor. You must pass your own builder function '
//         'to embedBuilder property of QuillEditor or QuillField widgets.',
//   );
// }
}

class _Toolbar extends ConsumerWidget {
  const _Toolbar({
    Key? key,
    required this.documentId,
  }) : super(key: key);

  final String documentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quillController = ref.watch(_quillControllerProvider(documentId));

    if (quillController == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return QuillToolbar.basic(
      controller: quillController,
      iconTheme: const QuillIconTheme(
        iconSelectedFillColor: AppColors.secondary,
      ),
      multiRowsDisplay: false,
      showAlignmentButtons: true,
    );
  }
}
