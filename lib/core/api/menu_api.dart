import 'package:control_bienes/core/api/core/http.dart';
import 'package:control_bienes/core/models/menu_response.dart';

class MenuApi {
  final Http _http;
  MenuApi(this._http);

  Future<Object> getMenu({required String rol}) {
    return _http.request(
      '/menu',
      method: 'GET',
      queryParameters: {
        "rol": rol,
      },
      parser: (data) {
        return MenuResponse.fromJson(data);
      },
    );
  }
}
