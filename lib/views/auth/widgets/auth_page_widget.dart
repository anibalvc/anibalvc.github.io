import 'package:control_bienes/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthPageWidget extends StatelessWidget {
  const AuthPageWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 100, 10, 0),
              child: Image.asset(
                'assets/img/sistema.jpg',
                width: 250,
                height: 250,
              ),
            ),
            Container(
                height: MediaQuery.of(context).size.height / 2,
                color: AppColors.white,
                // color: Colors.blueGrey,
                child: Center(child: child)),
          ],
        ),
      ),
    );
  }
}
