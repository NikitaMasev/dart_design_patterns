import 'dart:math';

import 'package:meta/meta.dart';

abstract class AuthMiddleware {
  AuthMiddleware? _nexMiddleware;

  AuthMiddleware bind(AuthMiddleware next) {
    _nexMiddleware = next;
    return next;
  }

  bool check(String email, String password);

  @protected
  bool checkNext(String email, String password) {
    if (_nexMiddleware == null) return true;
    return _nexMiddleware!.check(email, password);
  }
}

class EmailAuthMiddleware extends AuthMiddleware {
  @override
  bool check(String email, String password) {
    return Random().nextBool();
  }
}

class PasswordAuthMiddleware extends AuthMiddleware {
  @override
  bool check(String email, String password) {
    return Random().nextBool();
  }
}

class UserExistsAuthMiddleware extends AuthMiddleware {
  @override
  bool check(String email, String password) {
    return Random().nextBool();
  }
}

class Application {
  final AuthMiddleware _authMiddleware;
  static const _countUsers = 10;

  Application(this._authMiddleware);

  void start() {
    for (var i = 0; i < _countUsers; i++) {
      print('User $i is authenticated:'
          ' ${_authMiddleware.check('user$i', 'password$i')}');
    }
  }
}

void main() {
  final authMiddleware = EmailAuthMiddleware()
      .bind(PasswordAuthMiddleware())
      .bind(UserExistsAuthMiddleware());

  final app = Application(authMiddleware);
  app.start();
}
