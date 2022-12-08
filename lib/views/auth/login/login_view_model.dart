import 'package:control_bienes/core/api/autentication_api.dart';
import 'package:control_bienes/core/api/core/api_status.dart';
import 'package:control_bienes/core/api/menu_api.dart';
import 'package:control_bienes/core/authentication_client.dart';
import 'package:control_bienes/core/base/base_view_model.dart';
import 'package:control_bienes/core/locator.dart';
import 'package:control_bienes/core/models/menu_response.dart';
import 'package:control_bienes/core/models/sign_in_response.dart';
import 'package:control_bienes/core/providers/menu_provider.dart';
import 'package:control_bienes/core/services/navigator_service.dart';
import 'package:control_bienes/utils/cuentas.dart';
import 'package:control_bienes/views/auth/confirm_password/confirm_password_view.dart';
import 'package:control_bienes/views/home/home_view.dart';
import 'package:control_bienes/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginViewModel extends BaseViewModel {
  final _navigationService = locator<NavigatorService>();
  final _authenticationAPI = locator<AuthenticationAPI>();
  final _menuApi = locator<MenuApi>();
  final _autenticationClient = locator<AuthenticationClient>();
  final GlobalKey<FormState> formKey = GlobalKey();
  bool _loading = false;
  TextEditingController tcUsuario =
      TextEditingController(text: AppCuentas().usuarioDepartamento);
  TextEditingController tcClave =
      TextEditingController(text: AppCuentas().clave);
  bool obscurePassword = true;

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> signIn(BuildContext context, [bool mounted = true]) async {
    if (formKey.currentState!.validate()) {
      loading = true;
      var resp = await _authenticationAPI.signIn(
        usuario: tcUsuario.text,
        clave: tcClave.text,
      );
      if (resp is Success<Session>) {
        _autenticationClient.saveSession(resp.response);
        var resp1 = await _menuApi.getMenu(rol: resp.response.rol);
        if (resp1 is Success<MenuResponse>) {
          if (!mounted) return;
          Provider.of<MenuProvider>(context, listen: false).menu =
              resp1.response;
          loading = false;

          _navigationService.navigateToPageWithReplacement(HomeView.routeName);
        } else if (resp1 is Failure) {
          if (resp1.message != "No Internet") {
            loading = false;
            _navigationService
                .navigateToPageWithReplacement(HomeView.routeName);
          } else {
            loading = false;
            Dialogs.error(
              msg: resp1.message,
            );
          }
        }
      } else if (resp is Failure) {
        loading = false;
        Dialogs.error(
          msg: resp.message,
        );
      }
    }
  }

  void changeObscure() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }

  @override
  void dispose() {
    tcUsuario.dispose();
    tcClave.dispose();
    super.dispose();
  }

  goToConfigPassword() {
    _navigationService.navigateToPage(ConfirmPasswordView.routeName);
  }
}
