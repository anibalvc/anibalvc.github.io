import 'dart:convert';

InmueblesResponse inmueblesResponseFromJson(String str) =>
    InmueblesResponse.fromJson(json.decode(str));

String inmueblesResponseToJson(InmueblesResponse data) =>
    json.encode(data.toJson());

class InmueblesResponse {
  InmueblesResponse({
    required this.data,
  });

  List<InmueblesData> data;

  factory InmueblesResponse.fromJson(Map<String, dynamic> json) =>
      InmueblesResponse(
          data: json["data"]
              .map<InmueblesData>((e) => InmueblesData.fromJson(e))
              .toList());

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()),
      };
}

class InmueblesData {
  InmueblesData(
      {required this.id,
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
      required this.numOficio,
      required this.numExpediente});

  String ingresadoPor,
      fechaIngreso,
      descripcion,
      departamento,
      eliminadoPor,
      nombre,
      monto,
      numExpediente;
  int id, ordenPago, partidaCompra, numFactura, numBien, numOficio;

  factory InmueblesData.fromJson(Map<String, dynamic> json) => InmueblesData(
        id: json["id"] ?? 0,
        ordenPago: json["orden_pago"] ?? 0,
        partidaCompra: json["partida_compra"] ?? 0,
        numFactura: json["num_factura"] ?? 0,
        numBien: json["num_bien"] ?? 0,
        ingresadoPor: json["ingresado_por"] ?? '',
        eliminadoPor: json["eliminado_por"] ?? '',
        fechaIngreso: json["fecha_ingreso"] ?? '',
        descripcion: json["descripcion"] ?? '',
        monto: json["monto"] ?? "",
        numExpediente: json["num_expediente"] ?? "",
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
        "num_bien": numBien,
        "ingresado_por": ingresadoPor,
        "fecha_ingreso": fechaIngreso,
        "descripcion": descripcion,
        "monto": monto,
        "departamento": departamento,
        "numOficio": numOficio,
        "num_expediente": numExpediente
      };
}

InmueblesResponse inmueblePOSTResponseFromJson(String str) =>
    InmueblesResponse.fromJson(json.decode(str));

String inmueblePOSTResponseToJson(InmueblesResponse data) =>
    json.encode(data.toJson());

class InmueblePOSTResponse {
  InmueblePOSTResponse({required this.data});

  bool data;

  factory InmueblePOSTResponse.fromJson(Map<String, dynamic> json) =>
      InmueblePOSTResponse(data: json["data"]);

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
