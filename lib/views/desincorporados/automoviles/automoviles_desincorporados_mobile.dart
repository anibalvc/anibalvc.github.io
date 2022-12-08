part of automoviles_desincorporados_view;

class _AutomovilesDesincorporadosMobile extends StatelessWidget {
  final AutomovilesDesincorporadosViewModel vm;

  const _AutomovilesDesincorporadosMobile(this.vm);

  @override
  Widget build(BuildContext context) {
    return ProgressWidget(
      inAsyncCall: vm.cargando,
      opacity: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 3,
          title: const Text(
            'Automoviles Desincorporados',
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
                        onSubmitted: vm.buscarAutomovilesDesincorporados,
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
                                      vm.buscarAutomovilesDesincorporados(
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
                child: vm.automovilesDesincorporados.isEmpty
                    ? const RefreshWidget()
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: vm.automovilesDesincorporados.length,
                        controller: vm.listController,
                        itemBuilder: (context, i) {
                          var automovil = vm.automovilesDesincorporados[i];
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 3, horizontal: 5),
                            child: MaterialButton(
                              onPressed: () =>
                                  vm.modificarAutomovilesDesincorporados(
                                      context, automovil),
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
                                            automovil.nombre,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              color: AppColors.blueDark,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          Text(
                                            "Nro Bien: ${automovil.numBien}",
                                            style: const TextStyle(
                                                color: AppColors.blueDark,
                                                fontSize: 12),
                                          ),
                                          Text(
                                            "Departamento: ${automovil.departamento}",
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
