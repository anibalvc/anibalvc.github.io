import 'package:control_bienes/views/auth/confirm_password/confirm_password_view.dart';
import 'package:control_bienes/views/desincorporados/automoviles/automoviles_desincorporados_view.dart';
import 'package:control_bienes/views/desincorporados/inmueble/inmuebles_desincorporados_view.dart';
import 'package:control_bienes/views/desincorporados/muebles/muebles_desincorporados_view.dart';
import 'package:control_bienes/views/solicitudes/solicitudes_muebles/solicitudes_muebles_view.dart';
import 'package:control_bienes/views/trabajar/automoviles/automoviles_view.dart';
import 'package:control_bienes/views/trabajar/inmuebles/inmuebles_view.dart';
import 'package:control_bienes/views/trabajar/muebles/muebles_view.dart';
import 'package:control_bienes/widgets/escaner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../views/auth/login/login_view.dart';
import '../views/home/home_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());

    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => const LoginView());

    case ConfirmPasswordView.routeName:
      return MaterialPageRoute(
          builder: (context) => const ConfirmPasswordView());

    case EscanerPage.routeName:
      return CupertinoPageRoute(builder: (context) => const EscanerPage());

    case MueblesView.routeName:
      return CupertinoPageRoute(builder: (context) => const MueblesView());

    case MueblesDesincorporadosView.routeName:
      return CupertinoPageRoute(
          builder: (context) => const MueblesDesincorporadosView());

    case InmueblesView.routeName:
      return CupertinoPageRoute(builder: (context) => const InmueblesView());

    case InmueblesDesincorporadosView.routeName:
      return CupertinoPageRoute(
          builder: (context) => const InmueblesDesincorporadosView());

    case AutomovilesView.routeName:
      return CupertinoPageRoute(builder: (context) => const AutomovilesView());

    case AutomovilesDesincorporadosView.routeName:
      return CupertinoPageRoute(
          builder: (context) => const AutomovilesDesincorporadosView());

    case SolicitudesMueblesView.routeName:
      return CupertinoPageRoute(
          builder: (context) => const SolicitudesMueblesView());

    default:
      return MaterialPageRoute(builder: (context) => const HomeView());
  }
}
