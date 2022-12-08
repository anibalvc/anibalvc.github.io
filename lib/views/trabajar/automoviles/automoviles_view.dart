library automoviles_view;

import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/views/trabajar/automoviles/automoviles_view_model.dart';
import 'package:control_bienes/widgets/progress_widget.dart';
import 'package:control_bienes/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

part 'automoviles_mobile.dart';

class AutomovilesView extends StatelessWidget {
  static const routeName = 'Trabajar Automoviles';
  const AutomovilesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutomovilesViewModel viewModel = AutomovilesViewModel();
    return ViewModelBuilder<AutomovilesViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.onInit();
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _AutomovilesMobile(viewModel);
        });
  }
}
