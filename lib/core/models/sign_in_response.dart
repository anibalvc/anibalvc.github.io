class SignInResponse {
  SignInResponse({
    required this.data,
  });

  Session data;

  factory SignInResponse.fromJson(Map<String, dynamic> json) => SignInResponse(
        data: Session.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"data": data.toJson()};
}

class Session {
  Session(
      {required this.departamento,
      required this.nombre,
      required this.rol,
      required this.ingresadoPor,
      required this.usuario});

  String usuario;
  String nombre;
  String rol;
  String departamento;
  String ingresadoPor;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
      usuario: json["usuario"] ?? '',
      nombre: json["nombre"] ?? '',
      rol: json["rol"] ?? '',
      departamento: json["departamento"] ?? '',
      ingresadoPor: json["ingresado_por"] ?? '');

  Map<String, dynamic> toJson() => {
        "usuario": usuario,
        "nombre": nombre,
        "rol": rol,
        "departamento": departamento,
        "ingresado_por": ingresadoPor
      };
}
