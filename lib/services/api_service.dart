/* import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: 'https://687eb34fefe65e520087625f.mockapi.io/',
 // ضع هنا رابط السيرفر الخاص بك
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'Application/json',
      }));

  Future<Response> login(String username, String password) async {
    return await _dio
        .post('/login', data: {'username': username, 'password': password});
  }

  Future<Response> registerUser({
    required String firstName,
    required String lastName,
    required String username,
    required String proofNumber,
    required String email,
    required String phone,
    required String password,
    required String city,
  }) async {
    return await _dio.post('/register', data: {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'proof_number': proofNumber,
      'email': email,
      'phone': phone,
      'password': password,
      'city': city,
    });
  }
}
 */
import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://687eb34fefe65e520087625f.mockapi.io/',
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ),
  );

  /// تسجيل الدخول - GET يستخدم الاستعلام
  Future<Response> login(String username, String password) async {
    return await _dio.get(
      '/users',
      queryParameters: {
        'username': username,
        'password': password,
      },
    );
  }

  /// تسجيل مستخدم جديد
  Future<Response> registerUser({
    required String firstName,
    required String lastName,
    required String username,
    required String proofNumber,
    required String email,
    required String phone,
    required String password,
    required String city,
  }) async {
    return await _dio.post('/users', data: {
      'first_name': firstName,
      'last_name': lastName,
      'username': username,
      'proof_number': proofNumber,
      'email': email,
      'phone': phone,
      'password': password,
      'city': city,
    });
  }
}
