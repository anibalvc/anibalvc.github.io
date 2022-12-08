library muebles_desincorporados_view;

import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/views/desincorporados/muebles/muebles_desincorporados_view_model.dart';
import 'package:control_bienes/widgets/progress_widget.dart';
import 'package:control_bienes/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

part 'muebles_desincorporados_mobile.dart';

class MueblesDesincorporadosView extends StatelessWidget {
  static const routeName = 'Muebles Desincorporados';
  const MueblesDesincorporadosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MueblesDesincorporadosViewModel viewModel =
        MueblesDesincorporadosViewModel();
    return ViewModelBuilder<MueblesDesincorporadosViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.onInit();
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _MueblesDesincorporadosMobile(viewModel);
        });
  }
}
