import 'package:control_bienes/core/api/core/http.dart';
import 'package:control_bienes/core/models/trabajar/automovil_response.dart';

class AutomovilesApi {
  final Http _http;
  AutomovilesApi(this._http);

  Future<Object> getAutomovil(
      {String departamento = "",
      int? numBien,
      int? ordenPago,
      String nombre = ""}) async {
    return _http.request(
      '/automovil',
      method: 'GET',
      queryParameters: {
        "numBien": numBien,
        "ordenPago": ordenPago,
        "departamento": departamento,
        "nombre": nombre,
      },
      parser: (data) {
        return AutomovilesResponse.fromJson(data);
      },
    );
  }

  Future<Object> getAutomovilDeleted(
      {String departamento = "",
      int? numBien,
      int? ordenPago,
      int? numOficio}) async {
    return _http.request(
      '/automovildeleted',
      method: 'GET',
      queryParameters: {
        "numBien": numBien,
        "ordenPago": ordenPago,
        "departamento": departamento,
        "num_oficio": numOficio
      },
      parser: (data) {
        return AutomovilesResponse.fromJson(data);
      },
    );
  }

  Future<Object> createAutomovil(
      {required int ordenPago,
      required int partidaCompra,
      required int numFactura,
      required String descripcion,
      required String monto,
      required int numBien,
      required String departamento,
      required String ingresadoPor,
      required String nombre,
      required String numSerialMotor,
      required String numSerialCarroceria,
      required String numExpediente}) async {
    return _http.request(
      '/automovil',
      method: 'POST',
      data: {
        "fecha_ingreso": "",
        "orden_pago": ordenPago,
        "partida_compra": partidaCompra,
        "num_factura": numFactura,
        "descripcion": descripcion,
        "monto": monto,
        "num_bien": numBien,
        "departamento": departamento,
        "ingresado_por": ingresadoPor,
        "nombre": nombre,
        "num_serial_motor": numSerialMotor,
        "num_serial_carroceria": numSerialCarroceria,
        "num_expediente": numExpediente
      },
      parser: (data) {
        return AutomovilesData.fromJson(data);
      },
    );
  }

  Future<Object> updateAutomovil(
      {required int ordenPago,
      required int partidaCompra,
      required int numFactura,
      required String monto,
      required int numBien,
      required String departamento,
      required int id,
      required String nombre,
      required String numSerialMotor,
      required String numSerialCarroceria,
      required String numExpediente}) async {
    return _http.request(
      '/automovil/$id',
      method: 'PUT',
      data: {
        "nombre": nombre,
        "orden_pago": ordenPago,
        "partida_compra": partidaCompra,
        "num_factura": numFactura,
        "monto": monto,
        "num_bien": numBien,
        "departamento": departamento,
        "num_serial_motor": numSerialMotor,
        "num_serial_carroceria": numSerialCarroceria,
        "num_expediente": numExpediente
      },
      parser: (data) {
        return AutomovilesPOSTResponse.fromJson(data);
      },
    );
  }

  Future<Object> deleteAutomovil(
      {required int id,
      required String eliminadoPor,
      required int numOficio}) async {
    return _http.request(
      '/automovil/$id',
      method: 'DELETE',
      queryParameters: {"eliminado_por": eliminadoPor, "num_oficio": numOficio},
      parser: (data) {
        return AutomovilesPOSTResponse.fromJson(data);
      },
    );
  }
}
