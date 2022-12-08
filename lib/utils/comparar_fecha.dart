import 'package:intl/intl.dart';

abstract class CompararFechas {
  static int comparar({required String fecha}) {
    List<String> fechaDividad = fecha.split("/");
    DateTime fechaEntrada = DateTime(int.parse(fechaDividad[2]),
        int.parse(fechaDividad[1]), int.parse(fechaDividad[0]));
    DateTime date = DateTime.now();
    final DateFormat formatter = DateFormat('d/M/yyyy');
    fechaDividad = formatter.format(date).split("/");
    DateTime fechaActual = DateTime(int.parse(fechaDividad[2]),
        int.parse(fechaDividad[1]), int.parse(fechaDividad[0]));
    Duration ret = fechaActual.difference(fechaEntrada);
    return ret.inDays;
  }
}
