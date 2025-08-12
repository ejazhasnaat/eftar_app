import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import '../../../core/services/local_storage_service.dart';

class AuthRepository {
  final LocalStorageService _localStorage = LocalStorageService.instance;
  final http.Client _client;

  AuthRepository({http.Client? client}) : _client = client ?? http.Client();

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      final cached = await _localStorage.getCachedUser();
      if (cached != null && cached['email'] == email) {
        return cached;
      }
      throw Exception('No internet connection and no cached user found');
    }

    // replace with real API endpoint
    final response = await _client.post(
      Uri.parse('https://example.com/api/signin'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      await _localStorage.cacheUser(data);
      return data;
    }
    throw Exception('Failed to sign in');
  }

  Future<Map<String, dynamic>> signUp(String email, String password) async {
    final connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      throw Exception('No internet connection for sign up');
    }

    final response = await _client.post(
      Uri.parse('https://example.com/api/signup'),
      body: {'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      await _localStorage.cacheUser(data);
      return data;
    }
    throw Exception('Failed to sign up');
  }

  Future<void> signOut() async {
    await _localStorage.clear();
  }
}
