import 'package:control_bienes/core/api/core/api_status.dart';
import 'package:control_bienes/core/api/trabajar/inmuebles_api.dart';
import 'package:control_bienes/core/authentication_client.dart';
import 'package:control_bienes/core/models/sign_in_response.dart';
import 'package:control_bienes/core/models/trabajar/inmueble_response.dart';
import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/utils/comparar_fecha.dart';
import 'package:control_bienes/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';

class InmueblesDesincorporadosViewModel extends BaseViewModel {
  final _inmueblesDesincorporadosApi = locator<InmueblesApi>();
  final _authenticationClient = locator<AuthenticationClient>();
  final listController = ScrollController();
  TextEditingController tcBuscar = TextEditingController();

  List<InmueblesData> inmueblesDesincorporados = [];

  int pageNumber = 1;
  bool _cargando = false;
  bool _busqueda = false;
  late InmueblesResponse inmueblesDesincorporadosResponse;
  late Session usuario;

  bool get cargando => _cargando;
  set cargando(bool value) {
    _cargando = value;
    notifyListeners();
  }

  bool get busqueda => _busqueda;
  set busqueda(bool value) {
    _busqueda = value;
    notifyListeners();
  }

  void ordenar() {
    inmueblesDesincorporados.sort((a, b) {
      return a.nombre.compareTo(b.nombre);
    });
  }

  Future<void> onInit() async {
    cargando = true;
    usuario = _authenticationClient.loadSession;
    var resp = await _inmueblesDesincorporadosApi.getInmueblesDeleted();
    if (resp is Success) {
      inmueblesDesincorporadosResponse = resp.response as InmueblesResponse;
      inmueblesDesincorporados = inmueblesDesincorporadosResponse.data;
      ordenar();
      notifyListeners();
    }
    if (resp is Failure) {
      Dialogs.error(msg: resp.message);
    }
    cargando = false;
  }

  Future<void> buscarInmueblesDesincorporados(String query) async {
    cargando = true;
    var resp = await _inmueblesDesincorporadosApi.getInmueblesDeleted(
      numBien: int.parse(query),
    );
    if (resp is Success) {
      var temp = resp.response as InmueblesResponse;
      inmueblesDesincorporados = temp.data;
      ordenar();
      _busqueda = true;
      notifyListeners();
    }
    if (resp is Failure) {
      Dialogs.error(msg: resp.message);
    }
    cargando = false;
  }

  void limpiarBusqueda() {
    _busqueda = false;
    inmueblesDesincorporados = inmueblesDesincorporadosResponse.data;
    notifyListeners();
    tcBuscar.clear();
  }

  Future<void> onRefresh() async {
    inmueblesDesincorporados = [];
    cargando = true;
    var resp = await _inmueblesDesincorporadosApi.getInmueblesDeleted();
    if (resp is Success) {
      var temp = resp.response as InmueblesResponse;
      inmueblesDesincorporadosResponse = temp;
      inmueblesDesincorporados = temp.data;
      ordenar();
      notifyListeners();
    }
    if (resp is Failure) {
      Dialogs.error(msg: resp.message);
    }
    cargando = false;
  }

  Future<void> modificarInmueblesDesincorporados(
      BuildContext ctx, InmueblesData muebleDesincorporado) async {
    final GlobalKey<FormState> _formKey = GlobalKey();
    showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: EdgeInsets.zero,
              content: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: AppColors.brownLight,
                      child: const Text(
                        'Modificar Mueble',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Flexible(
                        child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: muebleDesincorporado.nombre,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Escriba un nombre';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Nombre"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                readOnly: true,
                                initialValue: muebleDesincorporado.numExpediente
                                    .toString(),
                                decoration: const InputDecoration(
                                  label: Text("Nro Expediente"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                readOnly: true,
                                initialValue:
                                    muebleDesincorporado.numBien.toString(),
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Escriba un nro bien';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Nro Bien"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                readOnly: true,
                                initialValue:
                                    muebleDesincorporado.numOficio.toString(),
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  label: Text("Nro Oficio"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue:
                                    muebleDesincorporado.ordenPago.toString(),
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Escriba una orden de pago';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Orden de Pago"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: muebleDesincorporado.partidaCompra
                                    .toString(),
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Escriba una partida de compra';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Partida de Compra"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue:
                                    muebleDesincorporado.numFactura.toString(),
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Escriba un número de factura';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Número de Factura"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue:
                                    muebleDesincorporado.monto.toString(),
                                readOnly: true,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Escriba un monto';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Monto"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: muebleDesincorporado.descripcion,
                                readOnly: true,
                                maxLines: 4,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Escriba una descripción';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Descripción"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                keyboardType: TextInputType.datetime,
                                readOnly: true,
                                initialValue: muebleDesincorporado.fechaIngreso,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Seleccione una fecha';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Fecha de Ingreso"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: muebleDesincorporado.departamento,
                                readOnly: true,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Escriba un departamento';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Departamento"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                AppIcons.closeCircle,
                                color: Colors.red,
                              ),
                              SizedBox(
                                height: 3,
                              ), // icon
                              Text("Cancelar"), // text
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            );
          });
        });
  }

  @override
  void dispose() {
    listController.dispose();
    tcBuscar.dispose();
    super.dispose();
  }
}
