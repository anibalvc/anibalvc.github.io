part of solicitudes_muebles_view;

class _SolicitudesMueblesMobile extends StatelessWidget {
  final SolicitudesMueblesViewModel vm;

  const _SolicitudesMueblesMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
      inAsyncCall: vm.cargando,
      opacity: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          title: const Text(
            'Solicitudes Muebles',
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
                        onSubmitted: vm.buscarSolicitudesMuebles,
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
                                  onPressed: () => vm.buscarSolicitudesMuebles(
                                      vm.tcBuscar.text),
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
                vm.usuario.rol != "General Bienes"
                    ? MaterialButton(
                        onPressed: () => vm.crearsolicitudMueble(context),
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
                    : const SizedBox.shrink()
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () => vm.onRefresh(),
                child: vm.solicitudesMuebles.isEmpty
                    ? const RefreshWidget()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: vm.solicitudesMuebles.length,
                        controller: vm.listController,
                        itemBuilder: (context, i) {
                          var solicitudMueble = vm.solicitudesMuebles[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            child: MaterialButton(
                              onPressed: () => vm.modificarSolicitudesMuebles(
                                  context, solicitudMueble),
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
                                            solicitudMueble.nombre,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: AppColors.blueDark,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(
                                            "Nro Bien: ${solicitudMueble.numBien}",
                                            style: const TextStyle(
                                                color: AppColors.blueDark,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Departamento: ${solicitudMueble.departamento}",
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
