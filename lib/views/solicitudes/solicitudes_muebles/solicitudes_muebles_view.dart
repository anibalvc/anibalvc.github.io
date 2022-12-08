library solicitudes_muebles_view;

import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/views/solicitudes/solicitudes_muebles/solicitudes_muebles_view_model.dart';
import 'package:control_bienes/widgets/progress_widget.dart';
import 'package:control_bienes/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

part 'solicitudes_muebles_mobile.dart';

class SolicitudesMueblesView extends StatelessWidget {
  static const routeName = 'Solicitudes Muebles';
  const SolicitudesMueblesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SolicitudesMueblesViewModel viewModel = SolicitudesMueblesViewModel();
    return ViewModelBuilder<SolicitudesMueblesViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.onInit();
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _SolicitudesMueblesMobile(viewModel);
        });
  }
}
