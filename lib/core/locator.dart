import 'package:control_bienes/core/api/autentication_api.dart';
import 'package:control_bienes/core/api/core/constants.dart';
import 'package:control_bienes/core/api/core/http.dart';
import 'package:control_bienes/core/api/menu_api.dart';
import 'package:control_bienes/core/api/solicitudes/solicitudes_muebles_api.dart';
import 'package:control_bienes/core/api/trabajar/automovil_api.dart';
import 'package:control_bienes/core/api/trabajar/inmuebles_api.dart';
import 'package:control_bienes/core/api/trabajar/muebles_api.dart';
import 'package:control_bienes/core/authentication_client.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/logger.dart';
import '../core/services/navigator_service.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

GetIt locator = GetIt.instance;

class LocatorInjector {
  static final Logger _log = getLogger('LocatorInjector');

  static Future<void> setupLocator() async {
    _log.d('Initializing Navigator Service');
    locator.registerLazySingleton(() => NavigatorService());
  }
}

abstract class DependencyInjection {
  static Future<void> initialize() async {
    final Dio dio = Dio(BaseOptions(baseUrl: server));
    Logger logger = Logger();
    Http http = Http(dio: dio, logger: logger, logsEnabled: true);
    final storage = await SharedPreferences.getInstance();

    final authenticationAPI = AuthenticationAPI(http);
    final mueblesApi = MueblesApi(http);
    final inmueblesApi = InmueblesApi(http);
    final automovilesApi = AutomovilesApi(http);
    final authenticationClient = AuthenticationClient(storage);
    final menuApi = MenuApi(http);
    final solicitudesMueblesApi = SolicitudesMueblesApi(http);

    locator.registerSingleton<AuthenticationAPI>(authenticationAPI);
    locator.registerSingleton<MenuApi>(menuApi);
    locator.registerSingleton<MueblesApi>(mueblesApi);
    locator.registerSingleton<AuthenticationClient>(authenticationClient);
    locator.registerSingleton<InmueblesApi>(inmueblesApi);
    locator.registerSingleton<AutomovilesApi>(automovilesApi);
    locator.registerSingleton<SolicitudesMueblesApi>(solicitudesMueblesApi);
  }
}
