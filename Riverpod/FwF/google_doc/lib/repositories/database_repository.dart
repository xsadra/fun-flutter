import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/constants.dart';
import '../app/providers.dart';
import '../models/models.dart';
import 'repository_exception.dart';

final _databaseRepositoryProvider = Provider<DatabaseRepository>((ref) {
  return DatabaseRepository(ref);
});

class DatabaseRepository with RepositoryExceptionMixin {
  DatabaseRepository(this._ref);

  final Ref _ref;

  static Provider<DatabaseRepository> get provider =>
      _databaseRepositoryProvider;

  Databases get _databases => _ref.read(Dependency.database);

  Future<void> createNewPage({
    required String documentId,
    required String owner,
  }) async {
    return exceptionHandler(
        _createPageAndDelta(owner: owner, documentId: documentId));
  }

  Future<void> _createPageAndDelta({
    required String documentId,
    required String owner,
  }) async {
    Future.wait([
      _databases.createDocument(
        collectionId: CollectionNames.pages,
        documentId: documentId,
        data: {
          'owner': owner,
          'title': null,
          'content': null,
        },
        databaseId: AppDB.id,
      ),
      _databases.createDocument(
        collectionId: CollectionNames.delta,
        documentId: documentId,
        data: {
          'delta': null,
          'user': null,
          'deviceId': null,
        },
        databaseId: AppDB.id,
      ),
    ]);
  }

  Future<DocumentPageData> getPage({required String documentId}) {
    return exceptionHandler(_getPage(documentId));
  }

  Future<DocumentPageData> _getPage(String documentId) async {
    final doc = await _databases.getDocument(
      collectionId: CollectionNames.pages,
      documentId: documentId,
      databaseId: AppDB.id,
    );
    return DocumentPageData.fromMap(doc.data);
  }

  Future<void> updatePage({
    required String documentId,
    required DocumentPageData data,
  }) async {
    return exceptionHandler(
      _databases.updateDocument(
        collectionId: CollectionNames.pages,
        documentId: documentId,
        data: data.toMap(),
        databaseId: AppDB.id,
      ),
    );
  }
}
