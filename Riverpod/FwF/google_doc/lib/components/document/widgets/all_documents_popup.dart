import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_doc/core/log/logger.dart';
import 'package:routemaster/routemaster.dart';

import '../../../app/navigation/routes.dart';
import '../../../app/providers.dart';
import '../../../app/state/state.dart';
import '../../../models/models.dart';

final _documentsProvider = FutureProvider<List<DocumentPageData>>((ref) {
  final accountId = ref.read(AuthService.provider).account!.$id;
  return ref.read(Repository.database).getAllPages(accountId: accountId);
});

class AllDocumentsPopup extends ConsumerStatefulWidget {
  const AllDocumentsPopup({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AllDocumentsPopopState();
}

class _AllDocumentsPopopState extends ConsumerState<AllDocumentsPopup> {
  @override
  Widget build(BuildContext context) {
    final documents = ref.watch(_documentsProvider);
    return documents.when(
      data: ((data) => _DocumentsGrid(documents: data)),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
      error: (e, st) => const Center(
        child: Text('Could not load data'),
      ),
    );
  }
}

class _DocumentsGrid extends StatelessWidget {
  const _DocumentsGrid({
    Key? key,
    required this.documents,
  }) : super(key: key);

  final List<DocumentPageData> documents;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      int crossAxisCount = 6;
      double verticalPadding = 32;
      final maxWidth = constraints.maxWidth;

      if (maxWidth < 1400) {
        verticalPadding = 28;
        crossAxisCount = 5;
      }
      if (maxWidth < 1100) {
        verticalPadding = 18;
        crossAxisCount = 4;
      }
      if (maxWidth < 900) {
        verticalPadding = 12;
        crossAxisCount = 3;
      }
      if (maxWidth < 500) {
        verticalPadding = 8;
        crossAxisCount = 2;
      }
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Text(
                'Your Documents',
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Scrollbar(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                  ),
                  itemCount: documents.length,
                  itemBuilder: (context, index) {
                    final documentPage = documents[index];
                    late final Document quillDoc;
                    if (documentPage.content.isEmpty) {
                      quillDoc = Document()..insert(0, '');
                    } else {
                      quillDoc = Document.fromDelta(documentPage.content);
                    }
                    late final String content;
                    if (!quillDoc.isEmpty()) {
                      content = quillDoc.toPlainText();
                    } else {
                      content = 'Empty';
                    }
                    final title = (documentPage.title.isEmpty)
                        ? 'No title'
                        : documentPage.title;

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              offset: const Offset(1, 3),
                              spreadRadius: 3,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Navigator.of(context).pop();
                              final path = '${AppRoutes.document}/${documentPage.id}';
                              logger.info('Navigating to $path');
                              Routemaster.of(context).push(
                                  path);
                            },
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: verticalPadding,
                                  ),
                                  child: Text(
                                    title,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    content,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
