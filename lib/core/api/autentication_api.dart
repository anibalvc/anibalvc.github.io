import 'package:control_bienes/core/api/core/http.dart';
import 'package:control_bienes/core/models/sign_in_response.dart';

class AuthenticationAPI {
  final Http _http;
  AuthenticationAPI(this._http);

  Future<Object> signIn({
    required String usuario,
    required String clave,
  }) {
    return _http.request(
      '/usuario/login',
      method: 'POST',
      data: {
        "usuario": usuario,
        "clave": clave,
      },
      parser: (data) {
        return Session.fromJson(data);
      },
    );
  }
}
