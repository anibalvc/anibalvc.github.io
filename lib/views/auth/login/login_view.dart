library home_view;

import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/widgets/app_buttons.dart';
import 'package:control_bienes/widgets/app_textfield.dart';
import 'package:control_bienes/widgets/progress_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/app_obscure_text_icon.dart';
import '../widgets/auth_page_widget.dart';
import 'login_view_model.dart';

part 'login_mobile.dart';

class LoginView extends StatelessWidget {
  static const routeName = 'login';
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginViewModel viewModel = LoginViewModel();
    return ViewModelBuilder<LoginViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _LoginMobile(viewModel);
        });
  }
}
