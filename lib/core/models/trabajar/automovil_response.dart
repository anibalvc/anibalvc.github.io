import 'dart:convert';

AutomovilesResponse automovilesResponseFromJson(String str) =>
    AutomovilesResponse.fromJson(json.decode(str));

String automovilesResponseToJson(AutomovilesResponse data) =>
    json.encode(data.toJson());

class AutomovilesResponse {
  AutomovilesResponse({
    required this.data,
  });

  List<AutomovilesData> data;

  factory AutomovilesResponse.fromJson(Map<String, dynamic> json) =>
      AutomovilesResponse(
          data: json["data"]
              .map<AutomovilesData>((e) => AutomovilesData.fromJson(e))
              .toList());

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()),
      };
}

class AutomovilesData {
  AutomovilesData(
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
      required this.numExpediente,
      required this.numSerialMotor,
      required this.numSerialCarroceria});

  String ingresadoPor,
      fechaIngreso,
      descripcion,
      departamento,
      eliminadoPor,
      nombre,
      monto,
      numExpediente,
      numSerialMotor,
      numSerialCarroceria;
  int id, ordenPago, partidaCompra, numFactura, numBien, numOficio;

  factory AutomovilesData.fromJson(Map<String, dynamic> json) =>
      AutomovilesData(
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
        numSerialMotor: json["num_serial_motor"] ?? '',
        numSerialCarroceria: json["num_serial_carroceria"] ?? '',
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
        "num_expediente": numExpediente,
        "num_serial_motor": numSerialMotor,
        "num_serial_carroceria": numSerialCarroceria
      };
}

AutomovilesResponse automovilPOSTResponseFromJson(String str) =>
    AutomovilesResponse.fromJson(json.decode(str));

String automovilPOSTResponseToJson(AutomovilesResponse data) =>
    json.encode(data.toJson());

class AutomovilesPOSTResponse {
  AutomovilesPOSTResponse({required this.data});

  bool data;

  factory AutomovilesPOSTResponse.fromJson(Map<String, dynamic> json) =>
      AutomovilesPOSTResponse(data: json["data"]);

  Map<String, dynamic> toJson() => {
        "data": data,
      };
}
