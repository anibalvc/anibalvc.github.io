import 'dart:convert';

MenuResponse menuResponseFromJson(String str) =>
    MenuResponse.fromJson(json.decode(str));

String menuResponseToJson(MenuResponse data) => json.encode(data.toJson());

class MenuResponse {
  MenuResponse({required this.data});

  List<MenuData> data;

  factory MenuResponse.fromJson(Map<String, dynamic> json) => MenuResponse(
        data: json["data"].map<MenuData>((e) => MenuData.fromJson(e)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "data": data.map((e) => e.toJson()).toList(),
      };
}

class MenuData {
  MenuData(
      {required this.id,
      required this.vista,
      required this.rol,
      this.items,
      required this.idPadre,
      required this.tienePadre,
      required this.ruta});

  String vista, ruta;
  int id, idPadre, tienePadre;
  String rol;
  List<MenuItemData>? items;

  factory MenuData.fromJson(Map<String, dynamic> json) => MenuData(
      id: json["id"] ?? 0,
      tienePadre: json["tienePadre"] ?? 0,
      idPadre: json["idPadre"] ?? 0,
      vista: json["vista"] ?? '',
      rol: json["rol"] ?? '',
      ruta: json["ruta"] ?? '',
      items: json["items"]
              ?.map<MenuItemData>((e) => MenuItemData.fromJson(e))
              .toList() ??
          []);

  Map<String, dynamic> toJson() => {
        "id": id,
        "vista": vista,
        "rol": rol,
        "items": items,
        "tienePadre": tienePadre
      };
}

class MenuItemData {
  MenuItemData(
      {required this.id,
      required this.vista,
      this.idPadre,
      required this.tienePadre,
      required this.ruta});

  String vista, ruta;
  int id, tienePadre;
  int? idPadre;

  factory MenuItemData.fromJson(Map<String, dynamic> json) => MenuItemData(
        id: json["id"] ?? 0,
        vista: json["vista"] ?? "",
        ruta: json["ruta"] ?? "",
        idPadre: json["idPadre"] ?? 0,
        tienePadre: json["tienePadre"] ?? 0,
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "vista": vista,
        "idPadre": idPadre,
        "tienePadre": tienePadre,
        "ruta": ruta
      };
}
