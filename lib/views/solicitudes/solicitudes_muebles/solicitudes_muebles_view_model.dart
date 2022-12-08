import 'package:control_bienes/core/api/core/api_status.dart';
import 'package:control_bienes/core/api/solicitudes/solicitudes_muebles_api.dart';
import 'package:control_bienes/core/authentication_client.dart';
import 'package:control_bienes/core/models/sign_in_response.dart';
import 'package:control_bienes/core/models/solicitudes/solicitudes_muebles_response.dart';
import 'package:control_bienes/theme/theme.dart';
import 'package:control_bienes/utils/comparar_fecha.dart';
import 'package:control_bienes/widgets/app_dialogs.dart';
import 'package:flutter/material.dart';

import '../../../core/base/base_view_model.dart';
import '../../../core/locator.dart';

class SolicitudesMueblesViewModel extends BaseViewModel {
  final _solicitudesMueblesApi = locator<SolicitudesMueblesApi>();
  final _authenticationClient = locator<AuthenticationClient>();
  final listController = ScrollController();
  TextEditingController tcBuscar = TextEditingController();
  TextEditingController tcNewDescripcion = TextEditingController();
  TextEditingController tcNewNumBien = TextEditingController();
  TextEditingController tcNewNombre = TextEditingController();
  TextEditingController tcNewDescripcionRechazo = TextEditingController();
  TextEditingController tcNewOrdenPago = TextEditingController();
  TextEditingController tcNewPartidaCompra = TextEditingController();
  TextEditingController tcNewNumFactura = TextEditingController();
  TextEditingController tcNewMonto = TextEditingController();

  List<SolicitudesMueblesData> solicitudesMuebles = [];

  int tcNewEsTecnologia = 0;
  int pageNumber = 1;
  bool _cargando = false;
  bool _busqueda = false;
  late SolicitudesMueblesResponse solicitudesMueblesResponse;
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
    solicitudesMuebles.sort((a, b) {
      return a.nombre.compareTo(b.nombre);
    });
  }

  Future<void> onInit() async {
    cargando = true;
    usuario = _authenticationClient.loadSession;
    var resp = await _solicitudesMueblesApi.getSolicitudesMuebles();
    if (resp is Success) {
      solicitudesMueblesResponse = resp.response as SolicitudesMueblesResponse;
      solicitudesMuebles = solicitudesMueblesResponse.data;
      ordenar();
      notifyListeners();
    }
    if (resp is Failure) {
      Dialogs.error(msg: resp.message);
    }
    cargando = false;
  }

  Future<void> buscarSolicitudesMuebles(String query) async {
    cargando = true;
    var resp = await _solicitudesMueblesApi.getSolicitudesMuebles(
      numBien: query.isEmpty ? null : int.parse(query),
    );
    if (resp is Success) {
      var temp = resp.response as SolicitudesMueblesResponse;
      solicitudesMuebles = temp.data;
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
    solicitudesMuebles = solicitudesMueblesResponse.data;
    notifyListeners();
    tcBuscar.clear();
  }

  Future<void> onRefresh() async {
    solicitudesMuebles = [];
    cargando = true;
    var resp = await _solicitudesMueblesApi.getSolicitudesMuebles();
    if (resp is Success) {
      var temp = resp.response as SolicitudesMueblesResponse;
      solicitudesMueblesResponse = temp;
      solicitudesMuebles = temp.data;
      ordenar();
      notifyListeners();
    }
    if (resp is Failure) {
      Dialogs.error(msg: resp.message);
    }
    cargando = false;
  }

  void clear() {
    tcNewNombre.clear();
    tcNewDescripcion.clear();
    tcNewNumBien.clear();
    tcNewDescripcionRechazo.clear();
    tcNewOrdenPago.clear();
    tcNewPartidaCompra.clear();
    tcNewNumFactura.clear();
    tcNewMonto.clear();
    tcNewEsTecnologia = 0;
  }

  Future<void> modificarSolicitudesMuebles(
      BuildContext ctx, SolicitudesMueblesData solicitudMueble) async {
    clear();
    tcNewDescripcion.text = solicitudMueble.descripcion;
    tcNewNombre.text = solicitudMueble.nombre;
    tcNewNumBien.text = solicitudMueble.numBien.toString();

    int diasDiferencia =
        CompararFechas.comparar(fecha: solicitudMueble.fechaSolicitud);

    bool mod24h = diasDiferencia > 1;
    bool mod15d = diasDiferencia > 15;
    bool esGeneralBienes = usuario.rol == "General Bienes" ? true : false;

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
                        'Modificar Solicitud Mueble',
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
                                readOnly: (mod24h || esGeneralBienes),
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
                                readOnly: mod24h || esGeneralBienes,
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
                                controller: tcNewDescripcion,
                                readOnly: mod24h || esGeneralBienes,
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
                                initialValue: solicitudMueble.fechaSolicitud,
                                validator: (value) {
                                  if (value!.trim() == '') {
                                    return 'Seleccione una fecha';
                                  } else {
                                    return null;
                                  }
                                },
                                decoration: const InputDecoration(
                                  label: Text("Fecha de Solicitud"),
                                  border: UnderlineInputBorder(),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                initialValue: solicitudMueble.departamento,
                                readOnly: true,
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
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        esGeneralBienes
                            ? TextButton(
                                onPressed: () async {
                                  tcNewDescripcionRechazo.clear();
                                  final GlobalKey<FormState> formKeyDes =
                                      GlobalKey();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                            clipBehavior: Clip.antiAlias,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            contentPadding: EdgeInsets.zero,
                                            content: Form(
                                                key: formKeyDes,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Container(
                                                      height: 82,
                                                      width: double.infinity,
                                                      alignment:
                                                          Alignment.center,
                                                      color:
                                                          AppColors.brownLight,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          'Rechazar Solicitud Mueble ${solicitudMueble.nombre}',
                                                          style:
                                                              const TextStyle(
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
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: TextFormField(
                                                          controller:
                                                              tcNewDescripcionRechazo,
                                                          validator: (value) {
                                                            if (value!.trim() ==
                                                                '') {
                                                              return 'Escriba una explicación del rechazo';
                                                            } else {
                                                              return null;
                                                            }
                                                          },
                                                          decoration:
                                                              const InputDecoration(
                                                            label: Text(
                                                                "Descripción del Rechazo"),
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
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                            tcNewDescripcion
                                                                .clear();
                                                          }, // button pressed
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const <
                                                                Widget>[
                                                              Icon(
                                                                AppIcons
                                                                    .closeCircle,
                                                                color:
                                                                    Colors.red,
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
                                                              ProgressDialog
                                                                  .show(
                                                                      context);
                                                              var resp =
                                                                  await _solicitudesMueblesApi
                                                                      .rechazarSolicitudesMuebles(
                                                                id: solicitudMueble
                                                                    .id,
                                                                fechaSolicitud:
                                                                    solicitudMueble
                                                                        .fechaSolicitud,
                                                                nombre:
                                                                    solicitudMueble
                                                                        .nombre,
                                                                descripcion:
                                                                    solicitudMueble
                                                                        .descripcion,
                                                                rechazadaPor:
                                                                    usuario
                                                                        .usuario,
                                                                descripcionRechazo:
                                                                    tcNewDescripcionRechazo
                                                                        .text
                                                                        .trim(),
                                                                numBien:
                                                                    solicitudMueble
                                                                        .numBien,
                                                                departamento:
                                                                    solicitudMueble
                                                                        .departamento,
                                                                solicitadoPor:
                                                                    solicitudMueble
                                                                        .solicitadoPor,
                                                              );

                                                              if (resp
                                                                  is Success) {
                                                                ProgressDialog
                                                                    .dissmiss(
                                                                        context);
                                                                Dialogs.success(
                                                                    msg:
                                                                        'Solicitud Mueble Rechazada');
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                clear();
                                                                await onRefresh();
                                                              }
                                                              ProgressDialog
                                                                  .dissmiss(
                                                                      context);
                                                              if (resp
                                                                  is Failure) {
                                                                Dialogs.error(
                                                                    msg: resp
                                                                        .message);
                                                              }
                                                            }
                                                          }, // button pressed
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: const <
                                                                Widget>[
                                                              Icon(
                                                                AppIcons.trash,
                                                                color: AppColors
                                                                    .grey,
                                                              ),
                                                              SizedBox(
                                                                height: 3,
                                                              ), // icon
                                                              Text(
                                                                  "Rechazar"), // text
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
                                    Text("Rechazar"), // text
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
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
                        !esGeneralBienes
                            ? TextButton(
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    ProgressDialog.show(context);
                                    var resp = await _solicitudesMueblesApi
                                        .updateSolicitudesMuebles(
                                            descripcion:
                                                tcNewDescripcion.text.trim(),
                                            id: solicitudMueble.id,
                                            nombre: tcNewNombre.text.trim(),
                                            numBien: int.parse(
                                                tcNewNumBien.text.trim()));
                                    ProgressDialog.dissmiss(context);
                                    if (resp is Success) {
                                      Dialogs.success(
                                          msg: 'Solicitud Mueble Actualizada');
                                      Navigator.of(context).pop();
                                      clear();
                                      await onRefresh();
                                    }

                                    if (resp is Failure) {
                                      Dialogs.error(msg: resp.message);
                                    }
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
                              )
                            : const SizedBox.shrink(),
                        esGeneralBienes
                            ? TextButton(
                                onPressed: () async {
                                  clear();
                                  final GlobalKey<FormState> formKeyDes =
                                      GlobalKey();
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return StatefulBuilder(
                                            builder: (context, setState) {
                                          return AlertDialog(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              contentPadding: EdgeInsets.zero,
                                              content: Form(
                                                  key: formKeyDes,
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Container(
                                                        height: 82,
                                                        width: double.infinity,
                                                        alignment:
                                                            Alignment.center,
                                                        color: AppColors
                                                            .brownLight,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Text(
                                                            'Aprobar Solicitud Mueble ${solicitudMueble.nombre}',
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            controller:
                                                                tcNewOrdenPago,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: (value) {
                                                              if (value!
                                                                      .trim() ==
                                                                  '') {
                                                                return 'Escriba una orden de pago';
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                              label: Text(
                                                                  "Orden de Pago"),
                                                              border:
                                                                  UnderlineInputBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            controller:
                                                                tcNewNumFactura,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: (value) {
                                                              if (value!
                                                                      .trim() ==
                                                                  '') {
                                                                return 'Escriba un número de factura';
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                              label: Text(
                                                                  "Número de Factura"),
                                                              border:
                                                                  UnderlineInputBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            controller:
                                                                tcNewPartidaCompra,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            validator: (value) {
                                                              if (value!
                                                                      .trim() ==
                                                                  '') {
                                                                return 'Escriba una partida de compra';
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                              label: Text(
                                                                  "Partida de Compra"),
                                                              border:
                                                                  UnderlineInputBorder(),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      CheckboxListTile(
                                                          value:
                                                              tcNewEsTecnologia ==
                                                                      1
                                                                  ? true
                                                                  : false,
                                                          title: const Text(
                                                              "¿Es Tecnología?"),
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              newValue!
                                                                  ? tcNewEsTecnologia =
                                                                      1
                                                                  : tcNewEsTecnologia =
                                                                      0;
                                                            });
                                                          }),
                                                      SizedBox(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: TextFormField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            controller:
                                                                tcNewMonto,
                                                            validator: (value) {
                                                              if (value!
                                                                      .trim() ==
                                                                  '') {
                                                                return 'Escriba un monto';
                                                              } else {
                                                                return null;
                                                              }
                                                            },
                                                            decoration:
                                                                const InputDecoration(
                                                              label:
                                                                  Text("Monto"),
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
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                              clear();
                                                            }, // button pressed
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const <
                                                                  Widget>[
                                                                Icon(
                                                                  AppIcons
                                                                      .closeCircle,
                                                                  color: Colors
                                                                      .red,
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
                                                            onPressed:
                                                                () async {
                                                              if (formKeyDes
                                                                  .currentState!
                                                                  .validate()) {
                                                                ProgressDialog
                                                                    .show(
                                                                        context);
                                                                var resp = await _solicitudesMueblesApi.aprobarSolicitudesMuebles(
                                                                    id: solicitudMueble
                                                                        .id,
                                                                    nombre: solicitudMueble
                                                                        .nombre,
                                                                    descripcion:
                                                                        solicitudMueble
                                                                            .descripcion,
                                                                    numBien: solicitudMueble
                                                                        .numBien,
                                                                    departamento:
                                                                        solicitudMueble
                                                                            .departamento,
                                                                    esTecnologia:
                                                                        tcNewEsTecnologia,
                                                                    fechaIngreso:
                                                                        "",
                                                                    ingresadoPor:
                                                                        usuario
                                                                            .usuario,
                                                                    monto: tcNewMonto
                                                                        .text
                                                                        .trim(),
                                                                    numFactura: int.parse(tcNewNumFactura
                                                                        .text
                                                                        .trim()),
                                                                    ordenPago: int.parse(
                                                                        tcNewOrdenPago
                                                                            .text
                                                                            .trim()),
                                                                    partidaCompra:
                                                                        int.parse(tcNewPartidaCompra.text.trim()));

                                                                if (resp
                                                                    is Success) {
                                                                  ProgressDialog
                                                                      .dissmiss(
                                                                          context);
                                                                  Dialogs.success(
                                                                      msg:
                                                                          'Solicitud Mueble Aprobada');
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop();
                                                                  clear();
                                                                  await onRefresh();
                                                                }
                                                                ProgressDialog
                                                                    .dissmiss(
                                                                        context);
                                                                if (resp
                                                                    is Failure) {
                                                                  Dialogs.error(
                                                                      msg: resp
                                                                          .message);
                                                                }
                                                              }
                                                            }, // button pressed
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: const <
                                                                  Widget>[
                                                                Icon(
                                                                  AppIcons
                                                                      .checkCircle,
                                                                  color:
                                                                      AppColors
                                                                          .green,
                                                                ),
                                                                SizedBox(
                                                                  height: 3,
                                                                ), // icon
                                                                Text(
                                                                    "Aprobar"), // text
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  )));
                                        });
                                      });
                                }, // button pressed
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const <Widget>[
                                    Icon(
                                      AppIcons.checkCircle,
                                      color: AppColors.green,
                                    ),
                                    SizedBox(
                                      height: 3,
                                    ), // icon
                                    Text("Aprobar"), // text
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
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

  Future<void> crearsolicitudMueble(BuildContext ctx) async {
    /* clear();
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
                        'Crear solicitudMueble',
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
                                  controller: tcNewSerialCarroceria,
                                  validator: (value) {
                                    if (value!.trim() == '') {
                                      return 'Escriba un Serial de Carroceria';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    label: Text("Serial de Carroceria"),
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tcNewSerialMotor,
                                  validator: (value) {
                                    if (value!.trim() == '') {
                                      return 'Escriba un Serial de Motor';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    label: Text("Serial de Motor"),
                                    border: UnderlineInputBorder(),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: tcNewNumExpediente,
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.trim() == '') {
                                      return 'Escriba un número de expediente';
                                    } else {
                                      return null;
                                    }
                                  },
                                  decoration: const InputDecoration(
                                    label: Text("Número de Expediente"),
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
                              var resp =
                                  await _SolicitudesMueblesApi.createsolicitudMueble(
                                      numSerialCarroceria:
                                          tcNewSerialCarroceria.text.trim(),
                                      numSerialMotor:
                                          tcNewSerialMotor.text.trim(),
                                      ordenPago:
                                          int.parse(tcNewOrdenPago.text.trim()),
                                      partidaCompra: int.parse(
                                          tcNewPartidaCompra.text.trim()),
                                      numFactura: int.parse(
                                          tcNewNumFactura.text.trim()),
                                      descripcion: tcNewDescripcion.text.trim(),
                                      monto: tcNewMonto.text.trim(),
                                      numBien:
                                          int.parse(tcNewNumBien.text.trim()),
                                      numExpediente:
                                          tcNewNumExpediente.text.trim(),
                                      nombre: tcNewNombre.text.trim(),
                                      departamento:
                                          tcNewDepartamento.text.trim(),
                                      ingresadoPor: usuario.usuario);

                              if (resp is Success) {
                                ProgressDialog.dissmiss(context);
                                Dialogs.success(msg: 'solicitudMueble Creado');
                                Navigator.of(context).pop();
                                await onRefresh();
                                clear();
                              }

                              if (resp is Failure) {
                                ProgressDialog.dissmiss(context);
                                Dialogs.error(msg: resp.message);
                              }
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
        }); */
  }

  @override
  void dispose() {
    tcNewNombre.dispose();
    tcNewDescripcion.dispose();
    tcNewNumBien.dispose();
    tcNewOrdenPago.dispose();
    tcNewPartidaCompra.dispose();
    tcNewNumFactura.dispose();
    tcNewMonto.dispose();
    listController.dispose();
    tcBuscar.dispose();
    super.dispose();
  }
}
