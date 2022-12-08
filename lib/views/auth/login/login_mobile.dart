part of home_view;

class _LoginMobile extends StatelessWidget {
  final LoginViewModel vm;

  const _LoginMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
      inAsyncCall: vm.loading,
      child: AuthPageWidget(
        child: Form(
          key: vm.formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTextField(
                text: 'Usuario',
                controller: vm.tcUsuario,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value!.length < 5) {
                    return "Usuario invalido";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              AppTextField(
                text: 'Contraseña',
                validator: (pass) {
                  if (pass!.trim().length < 5) {
                    return 'Contraseña inválida';
                  } else {
                    return null;
                  }
                },
                controller: vm.tcClave,
                obscureText: vm.obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                iconButton: AppObscureTextIcon(
                  icon: vm.obscurePassword
                      ? Icons.visibility_off
                      : Icons.visibility,
                  onPressed: vm.changeObscure,
                ),
              ),
              const SizedBox(height: 40),
              AppButtonLogin(
                icon: Icons.login_outlined,
                text: 'Iniciar Sesión',
                onPressed: () => vm.signIn(context),
                color: AppColors.blue,
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () => vm.goToConfigPassword(),
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
