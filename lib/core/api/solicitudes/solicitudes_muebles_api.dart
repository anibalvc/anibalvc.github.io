import 'package:control_bienes/core/api/core/http.dart';
import 'package:control_bienes/core/models/solicitudes/solicitudes_muebles_response.dart';

class SolicitudesMueblesApi {
  final Http _http;
  SolicitudesMueblesApi(this._http);

  Future<Object> getSolicitudesMuebles(
      {String departamento = "", int? numBien, String nombre = ""}) async {
    return _http.request(
      '/solicitudes-muebles',
      method: 'GET',
      queryParameters: {
        "numBien": numBien,
        "departamento": departamento,
        "nombre": nombre,
      },
      parser: (data) {
        return SolicitudesMueblesResponse.fromJson(data);
      },
    );
  }

  Future<Object> getSolicitudesMueblesRechazadas(
      {String departamento = "", String nombre = ""}) async {
    return _http.request(
      '/solicitudes-rechazadas-muebles',
      method: 'GET',
      queryParameters: {
        "nombre": nombre,
        "departamento": departamento,
      },
      parser: (data) {
        return SolicitudesMueblesResponse.fromJson(data);
      },
    );
  }

  Future<Object> createSolicitudesMuebles(
      {required String descripcion,
      required int numBien,
      required String departamento,
      required String solicitadoPor,
      required String nombre,
      required String tipoSolicitud}) async {
    return _http.request(
      '/solicitudes-muebles/create',
      method: 'POST',
      data: {
        "fecha_solicitud": "",
        "descripcion": descripcion,
        "num_bien": numBien,
        "departamento": departamento,
        "solicitado_por": solicitadoPor,
        "nombre": nombre,
        "tipo": "Mueble"
      },
      parser: (data) {
        return SolicitudesMueblesData.fromJson(data);
      },
    );
  }

  Future<Object> aprobarSolicitudesMuebles(
      {required String fechaIngreso,
      required int ordenPago,
      required int partidaCompra,
      required int numFactura,
      required String monto,
      required int numBien,
      required String departamento,
      required int id,
      required int esTecnologia,
      required String nombre,
      required String descripcion,
      required String ingresadoPor}) async {
    return _http.request(
      '/aprobar-solicitud-mueble',
      method: 'POST',
      queryParameters: {"idSolicitud": id},
      data: {
        "fecha_ingreso": fechaIngreso,
        "orden_pago": ordenPago,
        "partida_compra": partidaCompra,
        "num_factura": numFactura,
        "esTecnologia": esTecnologia,
        "nombre": nombre,
        "descripcion": descripcion,
        "monto": monto,
        "num_bien": numBien,
        "departamento": departamento,
        "ingresado_por": ingresadoPor
      },
      parser: (data) {
        return SolicitudesMueblesPOSTResponse.fromJson(data);
      },
    );
  }

  Future<Object> updateSolicitudesMuebles({
    required int numBien,
    required int id,
    required String nombre,
    required String descripcion,
  }) async {
    return _http.request(
      '/solicitudes-muebles/$id',
      method: 'PUT',
      data: {
        "nombre": nombre,
        "descripcion": descripcion,
        "num_bien": numBien,
      },
      parser: (data) {
        return SolicitudesMueblesPOSTResponse.fromJson(data);
      },
    );
  }

  Future<Object> deleteSolicitudesMuebles({
    required int id,
  }) async {
    return _http.request(
      '/solicitudes-muebles/$id',
      method: 'DELETE',
      parser: (data) {
        return SolicitudesMueblesPOSTResponse.fromJson(data);
      },
    );
  }

  Future<Object> rechazarSolicitudesMuebles({
    required int id,
    required String fechaSolicitud,
    required String nombre,
    required String descripcion,
    required String rechazadaPor,
    required String descripcionRechazo,
    required int numBien,
    required String departamento,
    required String solicitadoPor,
  }) async {
    return _http.request(
      '/rechazar-solicitud-mueble',
      method: 'DELETE',
      data: {
        "id": id,
        "fecha_solicitud": fechaSolicitud,
        "nombre": nombre,
        "descripcion": descripcion,
        "rechazada_por": rechazadaPor,
        "descripcion_rechazo": descripcionRechazo,
        "num_bien": numBien,
        "departamento": departamento,
        "solicitado_por": solicitadoPor,
        "tipo": "Mueble"
      },
      parser: (data) {
        return SolicitudesMueblesPOSTResponse.fromJson(data);
      },
    );
  }
}
