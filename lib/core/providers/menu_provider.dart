import 'package:control_bienes/core/models/menu_response.dart';
import 'package:flutter/material.dart';

class MenuProvider with ChangeNotifier {
  late MenuResponse _menu = MenuResponse(data: [
    MenuData(
        id: 0,
        vista: "",
        rol: "",
        idPadre: 0,
        tienePadre: 0,
        items: [],
        ruta: "")
  ]);
  MenuResponse get menu => _menu;
  set menu(MenuResponse value) {
    _menu = value;
    notifyListeners();
  }
}
