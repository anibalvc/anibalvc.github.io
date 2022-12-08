import 'dart:convert';

import 'package:control_bienes/core/models/sign_in_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationClient {
  SharedPreferences _storage;

  AuthenticationClient(this._storage);

  Future<void> initPrefs() async {
    _storage = await SharedPreferences.getInstance();
  }

  Session get loadSession {
    final data = _storage.getString('SESSION') ?? '';
    final session = Session.fromJson(jsonDecode(data));
    return session;
  }

  void saveSession(Session session) {
    final data = jsonEncode(session.toJson());
    _storage.setString('SESSION', data);
  }

  Future<void> signOut() async {
    await _storage.clear();
  }
}
