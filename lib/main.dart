import 'package:control_bienes/core/locator.dart';
import 'package:control_bienes/core/providers.dart';
import 'package:control_bienes/core/router.dart';
import 'package:control_bienes/core/services/navigator_service.dart';
import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/widgets/no_scale_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'views/auth/login/login_view.dart';

void main() async {
  /* Quitar barra de notificaciones */
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  WidgetsFlutterBinding.ensureInitialized();
  await LocatorInjector.setupLocator();
  await DependencyInjection.initialize();
  runApp(const MainApplication());
}

class MainApplication extends StatelessWidget {
  const MainApplication({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: ProviderInjector.providers,
      child: MaterialApp(
        title: 'Control Bienes',
        debugShowCheckedModeBanner: false,
        navigatorKey: locator<NavigatorService>().navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: LoginView.routeName,
        theme: myTheme,
        builder: (context, child) {
          return NoScaleTextWidget(
            child: child!,
          );
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('es', 'ES'),
          Locale('en', 'US'),
        ],
        locale: const Locale('es'),
      ),
    );
  }
}
