library inmuebles_desincorporados_view;

import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/views/desincorporados/inmueble/inmuebles_desincorporados_view_model.dart';
import 'package:control_bienes/widgets/progress_widget.dart';
import 'package:control_bienes/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

part 'inmuebles_desincorporados_mobile.dart';

class InmueblesDesincorporadosView extends StatelessWidget {
  static const routeName = 'Inmuebles Desincorporados';
  const InmueblesDesincorporadosView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InmueblesDesincorporadosViewModel viewModel =
        InmueblesDesincorporadosViewModel();
    return ViewModelBuilder<InmueblesDesincorporadosViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.onInit();
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _InmueblesDesincorporadosMobile(viewModel);
        });
  }
}
