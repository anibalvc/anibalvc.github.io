library inmuebles_view;

import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/views/trabajar/inmuebles/inmuebles_view_model.dart';
import 'package:control_bienes/widgets/progress_widget.dart';
import 'package:control_bienes/widgets/refresh_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

part 'inmuebles_mobile.dart';

class InmueblesView extends StatelessWidget {
  static const routeName = 'Trabajar Inmuebles';
  const InmueblesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InmueblesViewModel viewModel = InmueblesViewModel();
    return ViewModelBuilder<InmueblesViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) {
          viewModel.onInit();
          // Do something once your viewModel is initialized
        },
        builder: (context, viewModel, child) {
          return _InmueblesMobile(viewModel);
        });
  }
}
