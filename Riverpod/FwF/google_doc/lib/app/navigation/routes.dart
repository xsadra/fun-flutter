import 'package:routemaster/routemaster.dart' hide TransitionPage;

import '../components/auth/auth.dart';
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

final routesLoggedOut =
    RouteMap(onUnknownRoute: (_) => const Redirect(_login), routes: {
  _login: (_) => const TransitionPage(child: LoginPage()),
  _register: (_) => const TransitionPage(child: RegisterPage()),
});
