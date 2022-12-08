import 'package:control_bienes/theme/theme.dart';
import 'package:flutter/material.dart';

final icons = <String, IconData>{
  //Utilidad para obtener un icono segun su nombre mediante un map
  'Trabajar': Icons.work,
  'Desincorporados': Icons.delete,
  'Mant. Solicitudes': Icons.article_rounded,
  'Solicitudes': Icons.article_rounded,
  'Mantenimientos': Icons.settings,
  /* '': FontAwesomeIcons.penToSquare,
  '': FontAwesomeIcons.paperPlane, */
  // 'account_circle': Icons.account_circle,
  // 'account_circle': Icons.account_circle,
  // 'account_circle': Icons.account_circle,
  // 'account_circle': Icons.account_circle,
  // 'account_circle': Icons.account_circle,
  // 'account_circle': Icons.account_circle,
  // 'account_circle': Icons.account_circle,
  // 'account_circle': Icons.account_circle,
};

Icon getIcon(String nombreIcono) {
  Icon icon = Icon(icons[nombreIcono]);

  return icon;
}
