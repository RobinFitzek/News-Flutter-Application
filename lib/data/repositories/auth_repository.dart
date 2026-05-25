import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AuthRepository {
  Future<bool> isLoggedIn();
  Future<void> login();
  Future<void> logout();
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl();

  bool _isAuthenticated = false;

  @override
  Future<bool> isLoggedIn() async {
    return _isAuthenticated;
  }

  @override
  Future<void> login() async {
    _isAuthenticated = true;
  }

  @override
  Future<void> logout() async {
    _isAuthenticated = false;
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);
