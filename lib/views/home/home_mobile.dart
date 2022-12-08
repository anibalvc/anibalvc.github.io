part of home_view;

class _HomeMobile extends StatelessWidget {
  final HomeViewModel vm;

  const _HomeMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: GlobalDrawerDartDesktop(menuApp: vm.menu),
      appBar: AppBar(
        title: const Text('Mobile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              vm.user.usuario,
              style: const TextStyle(fontSize: 18),
            ),
            Text(
              vm.user.nombre,
              style: const TextStyle(fontSize: 18),
            ),
            Text(vm.user.rol, style: const TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}
