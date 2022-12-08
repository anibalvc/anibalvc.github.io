import 'package:control_bienes/core/api/core/api_status.dart';
import 'package:control_bienes/core/api/solicitudes/solicitudes_muebles_api.dart';
import 'package:control_bienes/core/api/trabajar/muebles_api.dart';
import 'package:control_bienes/core/authentication_client.dart';
import 'package:control_bienes/core/models/sign_in_response.dart';
import 'package:control_bienes/core/models/trabajar/muebles_response.dart';
import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/utils/comparar_fecha.dart';
import 'package:control_bienes/widgets/app_datetime_picker.dart';
import 'package:control_bienes/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';

class MueblesViewModel extends BaseViewModel {
  final _mueblesApi = locator<MueblesApi>();
  final _solicitudesMueblesApi = locator<SolicitudesMueblesApi>();
  final _authenticationClient = locator<AuthenticationClient>();
  final listController = ScrollController();
  TextEditingController tcBuscar = TextEditingController();
  TextEditingController tcNewDescripcion = TextEditingController();
  TextEditingController tcNewOrdenPago = TextEditingController();
  TextEditingController tcNewPartidaCompra = TextEditingController();
  TextEditingController tcNewNumFactura = TextEditingController();
  TextEditingController tcNewMonto = TextEditingController();
  TextEditingController tcNewNumBien = TextEditingController();
  TextEditingController tcNewDepartamento = TextEditingController();
  TextEditingController tcNewNombre = TextEditingController();
  TextEditingController tcNewNumOficio = TextEditingController();

  int tcNewEsTecnologia = 0;

  List<MueblesData> muebles = [];

  int pageNumber = 1;
  bool _cargando = false;
  bool _busqueda = false;
  late MueblesResponse mueblesResponse;
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
    muebles.sort((a, b) {
      return a.descripcion.compareTo(b.descripcion);
    });
  }

  Future<void> onInit() async {
    cargando = true;
    usuario = _authenticationClient.loadSession;
    var resp = await _mueblesApi.getMuebles(
        departamento:
            usuario.rol == "General Bienes" ? null : usuario.departamento);
    if (resp is Success) {
      mueblesResponse = resp.response as MueblesResponse;
      muebles = mueblesResponse.data;
      ordenar();
      notifyListeners();
    }
    if (resp is Failure) {
      Dialogs.error(msg: resp.message);
    }
    cargando = false;
  }

  Future<void> buscarMuebles(String query) async {
    cargando = true;
    var resp = await _mueblesApi.getMuebles(
        numBien: query.isEmpty ? null : int.parse(query),
        departamento:
            usuario.rol == "General Bienes" ? null : usuario.departamento);
    if (resp is Success) {
      var temp = resp.response as MueblesResponse;
      muebles = temp.data;
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
    muebles = mueblesResponse.data;
    notifyListeners();
    tcBuscar.clear();
  }

  Future<void> onRefresh() async {
    muebles = [];
    cargando = true;
    var resp = await _mueblesApi.getMuebles(
        departamento:
            usuario.rol == "General Bienes" ? null : usuario.departamento);
    if (resp is Success) {
      var temp = resp.response as MueblesResponse;
      mueblesResponse = temp;
      muebles = temp.data;
      ordenar();
      notifyListeners();
    }
    if (resp is Failure) {
      Dialogs.error(msg: resp.message);
    }
    cargando = false;
  }

  void clear() {
    tcNewDepartamento.clear();
    tcNewNombre.clear();
    tcNewEsTecnologia = 0;
    tcNewDescripcion.clear();
    tcNewMonto.clear();
    tcNewNumBien.clear();
    tcNewNumFactura.clear();
    tcNewOrdenPago.clear();
    tcNewPartidaCompra.clear();
  }

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

  Future<void> modificarMuebles(BuildContext ctx, MueblesData mueble) async {
    clear();
    tcNewDepartamento.text = mueble.departamento;
    tcNewDescripcion.text = mueble.descripcion;
    tcNewEsTecnologia = mueble.esTecnologia;
    tcNewNombre.text = mueble.nombre;
    tcNewMonto.text = mueble.monto.toString();
    tcNewNumBien.text = mueble.numBien.toString();
    tcNewNumFactura.text = mueble.numFactura.toString();
    tcNewOrdenPago.text = mueble.ordenPago.toString();
    tcNewPartidaCompra.text = mueble.partidaCompra.toString();

    int diasDiferencia = CompararFechas.comparar(fecha: mueble.fechaIngreso);

    bool mod24h = diasDiferencia > 1;
    bool mod15d = diasDiferencia > 15;
    bool puedeModificar = usuario.rol != "General Bienes";

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
                                controller: tcNewNombre,
                                readOnly: mod24h || puedeModificar,
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
                                readOnly: mod24h || puedeModificar,
                                controller: tcNewNumBien,
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
                                controller: tcNewOrdenPago,
                                readOnly: mod15d || puedeModificar,
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
                                controller: tcNewPartidaCompra,
                                readOnly: mod15d || puedeModificar,
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
                                controller: tcNewNumFactura,
                                readOnly: mod15d || puedeModificar,
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
                                controller: tcNewMonto,
                                readOnly: mod15d || puedeModificar,
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
                          CheckboxListTile(
                              value: tcNewEsTecnologia == 1 ? true : false,
                              title: const Text("¿Es Tecnología?"),
                              onChanged: (newValue) {
                                /* setState(() {
                                  newValue!
                                      ? tcNewEsTecnologia = 1
                                      : tcNewEsTecnologia = 0;
                                }); */
                              }),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                controller: tcNewDescripcion,
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
                                initialValue: mueble.fechaIngreso,
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
                                controller: tcNewDepartamento,
                                readOnly: true,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Escriba una descripción';
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
                          onPressed: () async {
                            final GlobalKey<FormState> formKeyDes = GlobalKey();
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                      clipBehavior: Clip.antiAlias,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      contentPadding: EdgeInsets.zero,
                                      content: Form(
                                          key: formKeyDes,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 82,
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                color: AppColors.brownLight,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    'Desincorporar Mueble ${mueble.nombre}',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: TextFormField(
                                                    controller: tcNewNumOficio,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    validator: (value) {
                                                      if (value!.trim() == '') {
                                                        return 'Escriba un No Oficio';
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    decoration:
                                                        const InputDecoration(
                                                      label: Text("No Oficio"),
                                                      border:
                                                          UnderlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                      tcNewDescripcion.clear();
                                                    }, // button pressed
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const <Widget>[
                                                        Icon(
                                                          AppIcons.closeCircle,
                                                          color: Colors.red,
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ), // icon
                                                        Text(
                                                            "Cancelar"), // text
                                                      ],
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      if (formKeyDes
                                                          .currentState!
                                                          .validate()) {
                                                        ProgressDialog.show(
                                                            context);
                                                        var resp = await _mueblesApi
                                                            .deleteMuebles(
                                                                id: mueble.id,
                                                                eliminadoPor:
                                                                    usuario
                                                                        .nombre,
                                                                numOficio: int.parse(
                                                                    tcNewNumOficio
                                                                        .text
                                                                        .trim()));

                                                        if (resp is Success) {
                                                          ProgressDialog
                                                              .dissmiss(
                                                                  context);
                                                          Dialogs.success(
                                                              msg:
                                                                  'Mueble Desincorporado');
                                                          Navigator.of(context)
                                                              .pop();
                                                          clear();
                                                          await onRefresh();
                                                        }
                                                        ProgressDialog.dissmiss(
                                                            context);
                                                        if (resp is Failure) {
                                                          Dialogs.error(
                                                              msg:
                                                                  resp.message);
                                                        }
                                                      }
                                                    }, // button pressed
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const <Widget>[
                                                        Icon(
                                                          AppIcons.trash,
                                                          color: AppColors.grey,
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ), // icon
                                                        Text(
                                                            "Desincorporar"), // text
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )));
                                });
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                AppIcons.trash,
                                color: AppColors.grey,
                              ),
                              SizedBox(
                                height: 3,
                              ), // icon
                              Text("Desincorporar"), // text
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            clear();
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
                        TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              ProgressDialog.show(context);
                              var resp = await _mueblesApi.updateMuebles(
                                  departamento: tcNewDepartamento.text.trim(),
                                  monto: tcNewMonto.text.trim(),
                                  numBien: int.parse(tcNewNumBien.text.trim()),
                                  numFactura:
                                      int.parse(tcNewNumFactura.text.trim()),
                                  ordenPago:
                                      int.parse(tcNewOrdenPago.text.trim()),
                                  partidaCompra:
                                      int.parse(tcNewPartidaCompra.text.trim()),
                                  id: mueble.id,
                                  esTecnologia: tcNewEsTecnologia,
                                  nombre: tcNewNombre.text.trim());
                              ProgressDialog.dissmiss(context);
                              if (resp is Success) {
                                Dialogs.success(msg: 'Mueble Actualizado');
                                Navigator.of(context).pop();
                                clear();
                                await onRefresh();
                              }

                              if (resp is Failure) {
                                ProgressDialog.dissmiss(context);
                                Dialogs.error(msg: resp.message);
                              }
                              clear();
                            }
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                AppIcons.save,
                                color: AppColors.green,
                              ),
                              SizedBox(
                                height: 3,
                              ), // icon
                              Text("Guardar"), // text
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  Future<void> crearMueble(BuildContext ctx) async {
    clear();
    final GlobalKey<FormState> formKey = GlobalKey();
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
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: AppColors.brownLight,
                      child: const Text(
                        'Crear Mueble',
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
                                  controller: tcNewNombre,
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
                                  controller: tcNewDescripcion,
                                  validator: (value) {
                                    if (value!.trim() == '') {
                                      return 'Escriba una descripción';
                                    } else {
                                      return null;
                                    }
                                  },
                                  maxLines: 5,
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
                                  controller: tcNewNumBien,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.trim() == '') {
                                      return 'Escriba un número de bien';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    label: Text("Número de Bien"),
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tcNewOrdenPago,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.trim() == '') {
                                      return 'Escriba un oden de pago';
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
                                  controller: tcNewPartidaCompra,
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
                                  controller: tcNewNumFactura,
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
                                  controller: tcNewMonto,
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
                            CheckboxListTile(
                                value: tcNewEsTecnologia == 1 ? true : false,
                                title: const Text("¿Es Tecnología?"),
                                onChanged: (newValue) {
                                  setState(() {
                                    newValue!
                                        ? tcNewEsTecnologia = 1
                                        : tcNewEsTecnologia = 0;
                                  });
                                }),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            tcNewDescripcion.clear();
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
                        TextButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              ProgressDialog.show(context);
                              var resp = await _mueblesApi.createMuebles(
                                  ordenPago:
                                      int.parse(tcNewOrdenPago.text.trim()),
                                  partidaCompra:
                                      int.parse(tcNewPartidaCompra.text.trim()),
                                  numFactura:
                                      int.parse(tcNewNumFactura.text.trim()),
                                  descripcion: tcNewDescripcion.text.trim(),
                                  monto: int.parse(tcNewMonto.text.trim()),
                                  numBien: int.parse(tcNewNumBien.text.trim()),
                                  esTecnologia: tcNewEsTecnologia,
                                  nombre: tcNewNombre.text.trim(),
                                  departamento: tcNewDepartamento.text.trim(),
                                  ingresadoPor: usuario.usuario);
                              if (resp is Success) {
                                Dialogs.success(msg: 'Mueble Creado');
                                Navigator.of(context).pop();
                                await onRefresh();
                                clear();
                              }
                              if (resp is Failure) {
                                Dialogs.error(msg: resp.message);
                              }
                              ProgressDialog.dissmiss(context);
                            }
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                AppIcons.save,
                                color: AppColors.green,
                              ),
                              SizedBox(
                                height: 3,
                              ), // icon
                              Text("Guardar"), // text
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

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  ///
  Future<void> crearSolicitudMueble(BuildContext ctx) async {
    clear();
    final GlobalKey<FormState> formKey = GlobalKey();
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
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 80,
                      width: double.infinity,
                      alignment: Alignment.center,
                      color: AppColors.brownLight,
                      child: const Text(
                        'Crear Mueble',
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
                                  controller: tcNewNombre,
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
                                  controller: tcNewDescripcion,
                                  validator: (value) {
                                    if (value!.trim() == '') {
                                      return 'Escriba una descripción';
                                    } else {
                                      return null;
                                    }
                                  },
                                  maxLines: 5,
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
                                  controller: tcNewNumBien,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.trim() == '') {
                                      return 'Escriba un número de bien';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    label: Text("Número de Bien"),
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            tcNewDescripcion.clear();
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
                        TextButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              ProgressDialog.show(context);
                              var resp = await _solicitudesMueblesApi
                                  .createSolicitudesMuebles(
                                      descripcion: tcNewDescripcion.text.trim(),
                                      numBien:
                                          int.parse(tcNewNumBien.text.trim()),
                                      nombre: tcNewNombre.text.trim(),
                                      departamento: usuario.departamento,
                                      solicitadoPor: usuario.usuario,
                                      tipoSolicitud: "Ingresar");

                              if (resp is Success) {
                                Dialogs.success(msg: 'Solicitud Mueble Creado');
                                Navigator.of(context).pop();
                                await onRefresh();
                                clear();
                              }

                              if (resp is Failure) {
                                Dialogs.error(msg: resp.message);
                              }
                              ProgressDialog.dissmiss(context);
                            }
                          }, // button pressed
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const <Widget>[
                              Icon(
                                AppIcons.save,
                                color: AppColors.green,
                              ),
                              SizedBox(
                                height: 3,
                              ), // icon
                              Text("Guardar"), // text
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
