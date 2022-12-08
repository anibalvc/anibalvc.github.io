import 'package:control_bienes/core/api/core/http.dart';
import 'package:control_bienes/core/models/trabajar/muebles_response.dart';

class MueblesApi {
  final Http _http;
  MueblesApi(this._http);

  Future<Object> getMuebles(
      {String? departamento = "",
      int? numBien,
      int? ordenPago,
      String nombre = ""}) async {
    return _http.request(
      '/mueble',
      method: 'GET',
      queryParameters: {
        "numBien": numBien,
        "ordenPago": ordenPago,
        "departamento": departamento,
        "nombre": nombre,
      },
      parser: (data) {
        return MueblesResponse.fromJson(data);
      },
    );
  }

  Future<Object> getMueblesDeleted(
      {String departamento = "",
      int? numBien,
      int? ordenPago,
      int? numOficio}) async {
    return _http.request(
      '/muebledeleted',
      method: 'GET',
      queryParameters: {
        "numBien": numBien,
        "ordenPago": ordenPago,
        "departamento": departamento,
        "num_oficio": numOficio
      },
      parser: (data) {
        return MueblesResponse.fromJson(data);
      },
    );
  }

  Future<Object> createMuebles(
      {required int ordenPago,
      required int partidaCompra,
      required int numFactura,
      required String descripcion,
      required int monto,
      required int numBien,
      required String departamento,
      required String ingresadoPor,
      required int esTecnologia,
      required String nombre}) async {
    return _http.request(
      '/mueble/create',
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
        "esTecnologia": esTecnologia,
        "nombre": nombre
      },
      parser: (data) {
        return MueblesData.fromJson(data);
      },
    );
  }

  Future<Object> updateMuebles(
      {required int ordenPago,
      required int partidaCompra,
      required int numFactura,
      required String monto,
      required int numBien,
      required String departamento,
      required int id,
      required int esTecnologia,
      required String nombre}) async {
    return _http.request(
      '/mueble/$id',
      method: 'PUT',
      data: {
        "esTecnologia": esTecnologia,
        "nombre": nombre,
        "orden_pago": ordenPago,
        "partida_compra": partidaCompra,
        "num_factura": numFactura,
        "monto": monto,
        "num_bien": numBien,
        "departamento": departamento,
      },
      parser: (data) {
        return MueblePOSTResponse.fromJson(data);
      },
    );
  }

  Future<Object> deleteMuebles(
      {required int id,
      required String eliminadoPor,
      required int numOficio}) async {
    return _http.request(
      '/mueble/$id',
      method: 'DELETE',
      queryParameters: {"eliminado_por": eliminadoPor, "num_oficio": numOficio},
      parser: (data) {
        return MueblesResponse.fromJson(data);
      },
    );
  }
}
