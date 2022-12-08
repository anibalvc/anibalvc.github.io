library automoviles_desincorporados_view;

import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/views/desincorporados/automoviles/automoviles_desincorporados_view_model.dart';
import 'package:control_bienes/widgets/progress_widget.dart';
import 'package:control_bienes/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

part 'automoviles_desincorporados_mobile.dart';

class AutomovilesDesincorporadosView extends StatelessWidget {
  static const routeName = 'Automoviles Desincorporados';
  const AutomovilesDesincorporadosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AutomovilesDesincorporadosViewModel viewModel =
        AutomovilesDesincorporadosViewModel();
    return ViewModelBuilder<AutomovilesDesincorporadosViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.onInit();
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _AutomovilesDesincorporadosMobile(viewModel);
        });
  }
}
