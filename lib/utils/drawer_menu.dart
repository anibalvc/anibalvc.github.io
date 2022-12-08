import 'package:control_bienes/core/models/menu_response.dart';
import 'package:control_bienes/utils/icon_string.dart';
import 'package:flutter/material.dart';

import '../core/locator.dart';
import '../core/services/navigator_service.dart';

List<Widget> menu(MenuResponse menu) {
  List<Widget> drawerMenu = [];
  final navigationService = locator<NavigatorService>();
  if (menu.data.first.vista != "") {
    for (var element in menu.data) {
      drawerMenu.add(
        element.items!.isNotEmpty
            ? ExpansionTile(
                maintainState: true,
                leading: getIcon(element.vista),
                title: Text(
                  element.vista,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                children: element.items!.map((e) {
                  return ListTile(
                    title: Text(
                      e.vista,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    onTap: () {
                      navigationService.navigateToPage(e.ruta);
                    },
                  );
                }).toList(),
              )
            : ListTile(
                title: Text(
                  element.vista,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.w500),
                ),
                onTap: () {
                  navigationService.navigateToPage(element.vista);
                },
              ),
      );
    }
  }
  return drawerMenu;
}
