part of confirm_password_view;

class _ConfirmPasswordMobile extends StatelessWidget {
  final ConfirmPasswordViewModel vm;

  const _ConfirmPasswordMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Configurar Contraseña')),
        body: Center(
          child: Form(
            key: vm.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                AppTextField(
                  text: 'Contraseña',
                  controller: vm.tcPassword,
                  obscureText: vm.obscurePassword,
                  iconButton: AppObscureTextIcon(
                    icon: vm.obscurePassword
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onPressed: vm.onChangeObscure,
                  ),
                  validator: vm.validator,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  text: 'Confirmar contraseña',
                  controller: vm.tcPasswordConfirm,
                  obscureText: vm.obscurePasswordConfirm,
                  iconButton: AppObscureTextIcon(
                    icon: vm.obscurePasswordConfirm
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onPressed: vm.onChangeObscureConfirm,
                  ),
                  validator: vm.validator,
                ),
                const SizedBox(height: 10),
                FlutterPwValidator(
                  controller: vm.tcPasswordConfirm,
                  minLength: 8,
                  uppercaseCharCount: 1,
                  numericCharCount: 1,
                  specialCharCount: 1,
                  width: MediaQuery.of(context).size.width * .90,
                  height: 120,
                  onSuccess: () => vm.isValidPassword = true,
                  onFail: () => vm.isValidPassword = false,
                  strings: FrenchStrings(),
                ),
                const SizedBox(height: 20),
                AppButtonLogin(
                    icon: Icons.lock_open,
                    text: 'Reiniciar Contraseña',
                    onPressed: () {
                      if (vm.formKey.currentState!.validate()) {}
                    },
                    color: AppColors.blueDark),
              ],
            ),
          ),
        ));
  }
}
