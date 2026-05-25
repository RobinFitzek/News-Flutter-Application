import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthRepository {
  Future<bool> isLoggedIn();
  bool isLoggedInSync();
  Future<void> login();
  Future<void> logout();
  Future<bool> isBiometricEnabled();
  Future<void> setBiometricEnabled(bool enabled);
}

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl() : _storage = const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  bool _isAuthenticated = false;
  bool _biometricEnabled = false;

  @override
  Future<bool> isLoggedIn() async {
    final enabled = await isBiometricEnabled();
    return !enabled || _isAuthenticated;
  }

  bool isLoggedInSync() {
    return !_biometricEnabled || _isAuthenticated;
  }

  @override
  Future<void> login() async {
    _isAuthenticated = true;
  }

  @override
  Future<void> logout() async {
    _isAuthenticated = false;
  }

  @override
  Future<bool> isBiometricEnabled() async {
    final saved = await _storage.read(key: 'biometric_enabled');
    return saved == 'true';
  }

  @override
  Future<void> setBiometricEnabled(bool enabled) async {
    _biometricEnabled = enabled;
    await _storage.write(key: 'biometric_enabled', value: enabled.toString());
  }
}

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(),
);
