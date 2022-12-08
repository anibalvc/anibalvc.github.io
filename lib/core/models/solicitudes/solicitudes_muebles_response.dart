import 'dart:convert';

SolicitudesMueblesResponse solicitudesmueblesResponseFromJson(String str) =>
    SolicitudesMueblesResponse.fromJson(json.decode(str));

String solicitudesmueblesResponseToJson(SolicitudesMueblesResponse data) =>
    json.encode(data.toJson());

class SolicitudesMueblesResponse {
  SolicitudesMueblesResponse({
    required this.data,
  });

  List<SolicitudesMueblesData> data;

  factory SolicitudesMueblesResponse.fromJson(Map<String, dynamic> json) =>
      SolicitudesMueblesResponse(
          data: json["data"]
              .map<SolicitudesMueblesData>(
                  (e) => SolicitudesMueblesData.fromJson(e))
              .toList());

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()),
      };
}

class SolicitudesMueblesData {
  SolicitudesMueblesData(
      {required this.id,
      required this.nombre,
      required this.departamento,
      required this.descripcion,
      required this.numBien,
      required this.tipo,
      required this.fechaSolicitud,
      required this.solicitadoPor});

  String solicitadoPor, fechaSolicitud, descripcion, departamento, nombre, tipo;
  int id, numBien;

  factory SolicitudesMueblesData.fromJson(Map<String, dynamic> json) =>
      SolicitudesMueblesData(
        id: json["id"] ?? 0,
        fechaSolicitud: json["fecha_solicitud"] ?? "",
        numBien: json["num_bien"] ?? 0,
        descripcion: json["descripcion"] ?? '',
        tipo: json["tipo"] ?? "",
        nombre: json["nombre"] ?? "",
        solicitadoPor: json["solicitado_por"] ?? "",
        departamento: json["departamento"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nombre": nombre,
        "num_bien": numBien,
        "solicitado_por": solicitadoPor,
        "descripcion": descripcion,
        "departamento": departamento,
        "tipo": tipo,
        "fecha_solicitud": fechaSolicitud
      };
}

SolicitudesMueblesResponse solicitudesmueblesPOSTResponseFromJson(String str) =>
    SolicitudesMueblesResponse.fromJson(json.decode(str));

String solicitudesmueblesPOSTResponseToJson(SolicitudesMueblesResponse data) =>
    json.encode(data.toJson());

class SolicitudesMueblesPOSTResponse {
  SolicitudesMueblesPOSTResponse({required this.data});

  bool data;

  factory SolicitudesMueblesPOSTResponse.fromJson(Map<String, dynamic> json) =>
      SolicitudesMueblesPOSTResponse(data: json["data"]);

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
