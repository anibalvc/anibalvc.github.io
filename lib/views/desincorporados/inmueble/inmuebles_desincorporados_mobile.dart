part of inmuebles_desincorporados_view;

class _InmueblesDesincorporadosMobile extends StatelessWidget {
  final InmueblesDesincorporadosViewModel vm;

  const _InmueblesDesincorporadosMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
      inAsyncCall: vm.cargando,
      opacity: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          title: const Text(
            'Inmuebles Desincorporados',
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
                        onSubmitted: vm.buscarInmueblesDesincorporados,
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
                                      vm.buscarInmueblesDesincorporados(
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
              ],
            ),
            Expanded(
              child: RefreshIndicator(
                triggerMode: RefreshIndicatorTriggerMode.anywhere,
                onRefresh: () => vm.onRefresh(),
                child: vm.inmueblesDesincorporados.isEmpty
                    ? const RefreshWidget()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: vm.inmueblesDesincorporados.length,
                        controller: vm.listController,
                        itemBuilder: (context, i) {
                          var inmueble = vm.inmueblesDesincorporados[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            child: MaterialButton(
                              onPressed: () =>
                                  vm.modificarInmueblesDesincorporados(
                                      context, inmueble),
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
                                            inmueble.nombre,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: AppColors.blueDark,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(
                                            "Nro Bien: ${inmueble.numBien}",
                                            style: const TextStyle(
                                                color: AppColors.blueDark,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Departamento: ${inmueble.departamento}",
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
