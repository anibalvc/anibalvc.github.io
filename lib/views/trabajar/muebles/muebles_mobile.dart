part of muebles_view;

class _MueblesMobile extends StatelessWidget {
  final MueblesViewModel vm;

  const _MueblesMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
      inAsyncCall: vm.cargando,
      opacity: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          title: const Text(
            'Muebles',
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          backgroundColor: AppColors.brownLight,
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: TextField(
                        controller: vm.tcBuscar,
                        onSubmitted: vm.buscarMuebles,
                        style: const TextStyle(
                          color: AppColors.blueDark,
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                        textInputAction: TextInputAction.search,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar por nro bien...',
                          hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              overflow: TextOverflow.ellipsis),
                          suffixIcon: !vm.busqueda
                              ? IconButton(
                                  icon: const Icon(AppIcons.search),
                                  onPressed: () =>
                                      vm.buscarMuebles(vm.tcBuscar.text),
                                  color: AppColors.blueDark,
                                )
                              : IconButton(
                                  onPressed: vm.limpiarBusqueda,
                                  icon: const Icon(
                                    AppIcons.closeCircle,
                                    color: AppColors.blueDark,
                                  )),
                        ),
                      ),
                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () {
                    if (vm.usuario.rol == "General Bienes") {
                      vm.crearMueble(context);
                    } else {
                      vm.crearSolicitudMueble(context);
                    }
                  },
                  color: Colors.white,
                  minWidth: 30,
                  height: 48,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 4,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      AppIcons.iconPlus,
                      color: AppColors.green,
                    ),
                  ),
                )
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () => vm.onRefresh(),
                child: vm.muebles.isEmpty
                    ? const RefreshWidget()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: vm.muebles.length,
                        controller: vm.listController,
                        itemBuilder: (context, i) {
                          var mueble = vm.muebles[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            child: MaterialButton(
                              onPressed: () =>
                                  vm.modificarMuebles(context, mueble),
                              color: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5)),
                              child: Container(
                                alignment: Alignment.centerLeft,
                                height: 70,
                                padding: const EdgeInsets.all(8),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mueble.nombre,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: AppColors.blueDark,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(
                                            "Nro Bien: ${mueble.numBien}",
                                            style: const TextStyle(
                                                color: AppColors.blueDark,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Departamento: ${mueble.departamento}",
                                            style: const TextStyle(
                                                color: AppColors.blueDark,
                                                fontSize: 12),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
