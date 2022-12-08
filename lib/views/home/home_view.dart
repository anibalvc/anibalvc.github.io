library home_view;

import 'package:control_bienes/core/providers/menu_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stacked/stacked.dart';

import '../../../widgets/global_drawer_widget.dart';
import 'home_view_model.dart';

part 'home_mobile.dart';

class HomeView extends StatelessWidget {
  static const routeName = 'home';
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var menu = Provider.of<MenuProvider>(context, listen: false).menu;
    HomeViewModel viewModel = HomeViewModel(menu);
    return ViewModelBuilder<HomeViewModel>.reactive(
        viewModelBuilder: () => viewModel,
        onModelReady: (viewModel) => viewModel.onInit(context),
        builder: (context, viewModel, child) {
          return _HomeMobile(viewModel);
        });
  }
}
