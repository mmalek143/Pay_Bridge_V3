import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pay_bridge/services/api_service.dart';
import 'package:dio/dio.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token;
  String? get token => _token;

  bool get isAuthenticated => _token != null;

  String? _error;
  String? get error => _error;

// فنكشن لعمل ايقونة اللودنق وتخزين الحساب في
//shared prefrences
  Future<bool> login(String user, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.login(user, password);

      if (response.data['token'] != null) {
        _token = response.data['token']; // تأكد من استلام التوكن من الـ API
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        _error = null;
        return true;
      } else {
        _error = "Invalid response from server";
        return false;
      }
    } on DioException catch (e) {
      _error = e.response?.data['message'] ?? 'Login fieled';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> registerUser({
    required String firstName,
    required String lastName,
    required String username,
    required String proofNumber,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String city,
  }) async {
    if (password != confirmPassword) {
      _error = "Passwords do not match";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.registerUser(
        firstName: firstName,
        lastName: lastName,
        username: username,
        proofNumber: proofNumber,
        email: email,
        phone: phone,
        password: password,
        city: city,
      );

      _token = response.data['token']; // لو فيه توكن
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      _error = null;
      return true;
    } on DioException catch (e) {
      _error = e.response?.data['message'] ?? 'Registration failed';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }

  Future<void> autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }
}

/* 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pay_bridge/services/api_service.dart';
import 'package:dio/dio.dart';

class AuthProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _token; // هذا توكن وهمي فقط
  String? get token => _token;

  String? _error;
  String? get error => _error;

  /// تسجيل الدخول باستخدام MockAPI
  Future<bool> login(String username, String password) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.login(username, password);

      if (response.data is List && response.data.length > 0) {
        // ✅ تسجيل ناجح
        final user = response.data[0];
        _token = user['id']; // نستعمل الـ id كمُعرّف وهمي بدل التوكن
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', _token!);
        _error = null;
        return true;
      } else {
        _error = "Invalid username or password";
        return false;
      }
    } on DioException catch (e) {
      _error = e.message ?? 'Login failed';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// إنشاء حساب جديد باستخدام MockAPI
  Future<bool> registerUser({
    required String firstName,
    required String lastName,
    required String username,
    required String proofNumber,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
    required String city,
  }) async {
    if (password != confirmPassword) {
      _error = "Passwords do not match";
      notifyListeners();
      return false;
    }

    _isLoading = true;
    notifyListeners();

    try {
      final response = await _apiService.registerUser(
        firstName: firstName,
        lastName: lastName,
        username: username,
        proofNumber: proofNumber,
        email: email,
        phone: phone,
        password: password,
        city: city,
      );

      _token = response.data['id']; // نستخدم id كتوكن بديل
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', _token!);
      _error = null;
      return true;
    } on DioException catch (e) {
      _error = e.message ?? 'Registration failed';
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// تسجيل الخروج
  Future<void> logout() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    notifyListeners();
  }
}
 */
