import 'dart:convert';

MueblesResponse mueblesResponseFromJson(String str) =>
    MueblesResponse.fromJson(json.decode(str));

String mueblesResponseToJson(MueblesResponse data) =>
    json.encode(data.toJson());

class MueblesResponse {
  MueblesResponse({
    required this.data,
  });

  List<MueblesData> data;

  factory MueblesResponse.fromJson(Map<String, dynamic> json) =>
      MueblesResponse(
          data: json["data"]
              .map<MueblesData>((e) => MueblesData.fromJson(e))
              .toList());

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()),
      };
}

class MueblesData {
  MueblesData(
      {required this.id,
      required this.esTecnologia,
      required this.nombre,
      required this.departamento,
      required this.descripcion,
      required this.fechaIngreso,
      required this.ingresadoPor,
      required this.monto,
      required this.numBien,
      required this.numFactura,
      required this.ordenPago,
      required this.partidaCompra,
      required this.eliminadoPor,
      required this.numOficio});

  String ingresadoPor,
      fechaIngreso,
      descripcion,
      departamento,
      eliminadoPor,
      nombre;
  int id,
      ordenPago,
      partidaCompra,
      numFactura,
      numBien,
      monto,
      esTecnologia,
      numOficio;

  factory MueblesData.fromJson(Map<String, dynamic> json) => MueblesData(
        id: json["id"] ?? 0,
        ordenPago: json["orden_pago"] ?? 0,
        partidaCompra: json["partida_compra"] ?? 0,
        numFactura: json["num_factura"] ?? 0,
        esTecnologia: json["esTecnologia"] ?? false,
        numBien: json["num_bien"] ?? 0,
        ingresadoPor: json["ingresado_por"] ?? '',
        eliminadoPor: json["eliminado_por"] ?? '',
        fechaIngreso: json["fecha_ingreso"] ?? '',
        descripcion: json["descripcion"] ?? '',
        monto: json["monto"] ?? 0,
        nombre: json["nombre"] ?? 0,
        numOficio: json["numOficio"] ?? 0,
        departamento: json["departamento"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orden_pago": ordenPago,
        "partida_compra": partidaCompra,
        "num_factura": numFactura,
        "nombre": nombre,
        "esTecnologia": esTecnologia,
        "num_bien": numBien,
        "ingresado_por": ingresadoPor,
        "fecha_ingreso": fechaIngreso,
        "descripcion": descripcion,
        "monto": monto,
        "departamento": departamento,
        "numOficio": numOficio
      };
}

MueblesResponse mueblePOSTResponseFromJson(String str) =>
    MueblesResponse.fromJson(json.decode(str));

String mueblePOSTResponseToJson(MueblesResponse data) =>
    json.encode(data.toJson());

class MueblePOSTResponse {
  MueblePOSTResponse({required this.data});

  bool data;

  factory MueblePOSTResponse.fromJson(Map<String, dynamic> json) =>
      MueblePOSTResponse(data: json["data"]);

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
