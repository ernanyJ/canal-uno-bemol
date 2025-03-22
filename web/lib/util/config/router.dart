import 'package:canaluno/data/models/user_model.dart';
import 'package:canaluno/presentation/pages/auth_provider.dart';
import 'package:canaluno/presentation/pages/home/home_page.dart';
import 'package:canaluno/presentation/pages/login/login_page.dart';
import 'package:canaluno/util/deserialize_jwt.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      if (state.path?.contains('/login') == true) {
        return null;
      }

      if (state.path == null && globalToken.isEmpty) {
        return '/login';
      } else if (state.path == null && globalToken.isNotEmpty) {
        return '/home';
      }

      // check if token is valid each route
      final expDate = getExpDate();

      if (expDate != null) {
        if (expDate.isAfter(DateTime.now())) {
          AuthProvider().clear();
          return '/login';
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomePage(loggedUser: state.extra as UserModel?),
      ),
    ],
  );
}
