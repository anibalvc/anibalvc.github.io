library muebles_view;

import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/views/trabajar/muebles/muebles_view_model.dart';
import 'package:control_bienes/widgets/progress_widget.dart';
import 'package:control_bienes/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

part 'muebles_mobile.dart';

class MueblesView extends StatelessWidget {
  static const routeName = 'Trabajar Muebles';
  const MueblesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MueblesViewModel viewModel = MueblesViewModel();
    return ViewModelBuilder<MueblesViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.onInit();
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _MueblesMobile(viewModel);
        });
  }
}
