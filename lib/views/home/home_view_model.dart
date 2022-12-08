import 'package:control_bienes/core/authentication_client.dart';
import 'package:control_bienes/core/base/base_view_model.dart';
import 'package:control_bienes/core/locator.dart';
import 'package:control_bienes/core/models/menu_response.dart';
import 'package:control_bienes/core/models/profile_response.dart';
import 'package:control_bienes/core/models/sign_in_response.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';

class HomeViewModel extends BaseViewModel {
  final _authenticationClient = locator<AuthenticationClient>();
  bool _loading = false;
  late Session _user;
  late Profile _userData;
  final logger = Logger();
  final MenuResponse _menu;
  HomeViewModel(this._menu);

  MenuResponse get menu => _menu;

  Session get user => _user;
  Profile get userData => _userData;
  set user(Session value) {
    _user = value;
    notifyListeners();
  }

  set userData(Profile value) {
    _userData = value;
    notifyListeners();
  }

  bool get loading => _loading;
  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> onInit(BuildContext context) async {
    user = _authenticationClient.loadSession;
    // await getRoles(context);
  }
}
