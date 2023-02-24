import 'package:routemaster/routemaster.dart' hide TransitionPage;

import '../../components/auth/auth.dart';
import '../../components/document/document.dart';
import '../../core/log/logger.dart';
import 'transition_page.dart';

const _login = '/login';
const _register = '/register';
const _document = '/document';
const _newDocument = '/newDocument';

abstract class AppRoutes {
  static String get login => _login;

  static String get register => _register;

  static String get document => _document;

  static String get newDocument => _newDocument;
}

final routesLoggedOut = RouteMap(
  onUnknownRoute: (_) => const Redirect(_login),
  routes: {
    _login: (_) => const TransitionPage(child: LoginPage()),
    _register: (_) => const TransitionPage(child: RegisterPage()),
  },
);

final routesLoggedIn = RouteMap(
  onUnknownRoute: (_) => const Redirect(_newDocument),
  routes: {
    _newDocument: (_) {
      logger.info('Go to new Document');
      return const TransitionPage(child: NewDocumentPage());
    },
    '$_document/:id': (info) {
      final id = info.pathParameters['id'];
      logger.info('$_document/${id ?? 'null'}');
      if (id == null) {
        return const Redirect(_newDocument);
      }
      return TransitionPage(
        child: DocumentPage(documentId: id),
      );
    },
  },
);
