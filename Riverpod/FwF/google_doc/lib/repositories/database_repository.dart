import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/constants.dart';
import '../app/providers.dart';
import '../core/log/logger.dart';
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

  Realtime get _realTime => _ref.read(Dependency.realtime);

  Future<void> createNewPage({
    required String documentId,
    required String owner,
  }) async {
    logger.info('Creating new page with id: $documentId');
    return exceptionHandler(
        _createPageAndDelta(owner: owner, documentId: documentId));
  }

  Future<void> _createPageAndDelta({
    required String documentId,
    required String owner,
  }) async {
    logger.info('Creating new page and delta with id: $documentId');
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
          'account': null,
          'deviceId': null,
        },
        databaseId: AppDB.id,
      ),
    ]);
  }

  Future<DocumentPageData> getPage({required String documentId}) {
    logger.info('Getting page with id: $documentId');
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
    logger.info('Updating page with id: $documentId');
    return exceptionHandler(
      _databases.updateDocument(
        collectionId: CollectionNames.pages,
        documentId: documentId,
        data: data.toMap(),
        databaseId: AppDB.id,
      ),
    );
  }

  Future<void> updateDelta({
    required String pageId,
    required DeltaData data,
  }) async {
    logger.info('Updating delta with id: $pageId');
    return exceptionHandler(
      _databases.updateDocument(
        collectionId: CollectionNames.delta,
        documentId: pageId,
        data: data.toMap(),
        databaseId: AppDB.id,
      ),
    );
  }

  RealtimeSubscription subscribeToPage({
    required String pageId,
  }) {
    try {
      var documentIdChannel =
          'databases.${AppDB.id}.${CollectionNames.deltaDocumentsPath}.$pageId';
      logger.info(
          '--Subscribing to page changes with documentIdChannel: $documentIdChannel');
      return _realTime.subscribe(
        [
          documentIdChannel,
        ],
      );
    } on AppwriteException catch (e) {
      logger.warning(e.message, e);
      throw RepositoryException(message: e.message ?? 'Unknown error');
    } on Exception catch (e, s) {
      logger.severe('Error subscription to page changes', e, s);
      throw RepositoryException(
          message: 'Error subscription to page changes',
          exception: e,
          stackTrace: s);
    }
  }
}
