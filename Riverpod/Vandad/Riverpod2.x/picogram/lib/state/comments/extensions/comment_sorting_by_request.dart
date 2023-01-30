import '../../../lib.dart';

extension Sorting on Iterable<Comment> {
  Iterable<Comment> sortByRequest(RequestForPostAndComment request) {
    if (request.sortByCreatedAt) {
      final sortedDocuments = toList()
        ..sort((a, b) {
          switch (request.sortOrder) {
            case SortOrder.newOnTop:
              return b.createdAt.compareTo(a.createdAt);
            case SortOrder.oldOnTop:
              return a.createdAt.compareTo(b.createdAt);
          }
        });
      return sortedDocuments;
    } else {
      return this;
    }
  }
}
