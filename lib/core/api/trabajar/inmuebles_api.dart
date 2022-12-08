import 'package:control_bienes/core/api/core/http.dart';
import 'package:control_bienes/core/models/trabajar/inmueble_response.dart';

class InmueblesApi {
  final Http _http;
  InmueblesApi(this._http);

  Future<Object> getInmuebles(
      {String departamento = "",
      int? numBien,
      int? ordenPago,
      String nombre = ""}) async {
    return _http.request(
      '/inmueble',
      method: 'GET',
      queryParameters: {
        "numBien": numBien,
        "ordenPago": ordenPago,
        "departamento": departamento,
        "nombre": nombre,
      },
      parser: (data) {
        return InmueblesResponse.fromJson(data);
      },
    );
  }

  Future<Object> getInmueblesDeleted(
      {String departamento = "",
      int? numBien,
      int? ordenPago,
      String nombre = ""}) async {
    return _http.request(
      '/inmuebledeleted',
      method: 'GET',
      queryParameters: {
        "numBien": numBien,
        "ordenPago": ordenPago,
        "departamento": departamento,
        "nombre": nombre
      },
      parser: (data) {
        return InmueblesResponse.fromJson(data);
      },
    );
  }

  Future<Object> createInmuebles(
      {required int ordenPago,
      required int partidaCompra,
      required int numFactura,
      required String descripcion,
      required String monto,
      required int numBien,
      required String departamento,
      required String ingresadoPor,
      required String numExpediente,
      required String nombre}) async {
    return _http.request(
      '/inmueble',
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
        "num_expediente": numExpediente,
        "nombre": nombre
      },
      parser: (data) {
        return InmueblesData.fromJson(data);
      },
    );
  }

  Future<Object> updateInmuebles(
      {required int ordenPago,
      required int partidaCompra,
      required int numFactura,
      required String monto,
      required int numBien,
      required String departamento,
      required int id,
      required String nombre,
      required String numExpediente}) async {
    return _http.request(
      '/inmueble/$id',
      method: 'PUT',
      data: {
        "nombre": nombre,
        "orden_pago": ordenPago,
        "partida_compra": partidaCompra,
        "num_factura": numFactura,
        "monto": monto,
        "num_bien": numBien,
        "departamento": departamento,
        "num_expediente": numExpediente
      },
      parser: (data) {
        return InmueblePOSTResponse.fromJson(data);
      },
    );
  }

  Future<Object> deleteInmuebles(
      {required int id,
      required String eliminadoPor,
      required int numOficio}) async {
    return _http.request(
      '/inmueble/$id',
      method: 'DELETE',
      queryParameters: {"eliminado_por": eliminadoPor},
      parser: (data) {
        return InmueblesResponse.fromJson(data);
      },
    );
  }
}
