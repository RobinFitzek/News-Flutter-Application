import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class AuthRepository extends ChangeNotifier {
  bool isLoggedInSync();
  void loginSync();
  void logoutSync();
  int get authVersion;
  Future<bool> isBiometricEnabled();
  Future<void> setBiometricEnabled(bool enabled);
}

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl() : _storage = const FlutterSecureStorage() {
    _loadInitialState();
  }

  final FlutterSecureStorage _storage;
  bool _isAuthenticated = false;
  bool _biometricEnabled = false;
  int _authVersion = 0;

  Future<void> _loadInitialState() async {
    final saved = await _storage.read(key: 'biometric_enabled');
    _biometricEnabled = saved == 'true';
    // If biometric not enabled, user is authenticated by default
    _isAuthenticated = !_biometricEnabled;
    _authVersion++;
    notifyListeners();
  }

  @override
  bool isLoggedInSync() {
    // If biometric is not enabled, always allow access
    // If biometric IS enabled, check if user has authenticated
    return !_biometricEnabled || _isAuthenticated;
  }

  @override
  void loginSync() {
    _isAuthenticated = true;
    _authVersion++;
    notifyListeners();
  }

  @override
  void logoutSync() {
    _isAuthenticated = false;
    _authVersion++;
    notifyListeners();
  }

  @override
  int get authVersion => _authVersion;

  @override
  Future<bool> isBiometricEnabled() async {
    await _loadInitialState();
    return _biometricEnabled;
  }

  @override
  Future<void> setBiometricEnabled(bool enabled) async {
    _biometricEnabled = enabled;
    _isAuthenticated = !enabled;
    await _storage.write(key: 'biometric_enabled', value: enabled.toString());
    _authVersion++;
    notifyListeners();
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl();
});
