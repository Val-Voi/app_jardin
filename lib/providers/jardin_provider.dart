import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

class JardinProvider {
  final String apiURL = 'http://10.0.2.2:8000/api';

  //retorna la lista de niños

  // --------------------PROVIDER NIÑOS--------------------

  // lista niños
  Future<List<dynamic>> getNinos() async {
    var uri = Uri.parse('$apiURL/ninos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //agregar un niño

  Future<LinkedHashMap<String, dynamic>> ninoAgregar(
    String nombre,
    String apellido,
    //DateTime fecha_nacimiento,
    String rut,
    String contacto_apoderado,
    //int nivel_id
  ) async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '/Application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'apellido': apellido,
          //'fecha_nacimiento': fecha_nacimiento,
          'rut': rut,
          'contacto_apoderado': contacto_apoderado,
          //'nivel_id': nivel_id,
        }));
    return json.decode(respuesta.body);
  }

  //borra un niño
  Future<bool> ninoBorrar(int id) async {
    var uri = Uri.parse('$apiURL/ninos/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  //datos de 1 niño
  Future<LinkedHashMap<String, dynamic>> getNino(int id) async {
    var uri = Uri.parse('$apiURL/niños/$id');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //editar un niño
  Future<LinkedHashMap<String, dynamic>> ninoEditar(
      int id,
      String nombre,
      DateTime fecha_nacimiento,
      String rut,
      String contacto_apoderado,
      int niveles_id) async {
    var uri = Uri.parse('$apiURL/niños/$id');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'fecha_nacimiento': fecha_nacimiento,
          'rut': rut,
          'contacto_apoderado': contacto_apoderado,
          'nivel_id': niveles_id,
        }));

    return json.decode(respuesta.body);
  }

  //------------------------- PROVIDER EDUCADORAS---------------------

  // lista educadoras
  Future<List<dynamic>> getEducadoras() async {
    var uri = Uri.parse('$apiURL/educadoras');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //agregar educadora

  Future<LinkedHashMap<String, dynamic>> educadoraAgregar(String nombre,
      String rut, String telefono_contacto, String correo_contacto) async {
    var uri = Uri.parse('$apiURL/educadoras');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '/Application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'rut': rut,
          'telefono_contacto': telefono_contacto,
          'correo_contacto': correo_contacto,
        }));
    //agregarEducadoraNivel(niveles_id);
    return json.decode(respuesta.body);
  }

  //borra una educadora
  Future<bool> educadoraBorrar(int id) async {
    var uri = Uri.parse('$apiURL/educadoras/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  //datos de 1 educadora
  Future<LinkedHashMap<String, dynamic>> getEducadora(int id) async {
    var uri = Uri.parse('$apiURL/educadoras/$id');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //editar una educadora
  Future<LinkedHashMap<String, dynamic>> educadoraEditar(
      int id,
      String nombre,
      String rut,
      String telefono_contacto,
      String correo_contacto,
      int niveles_id) async {
    var uri = Uri.parse('$apiURL/educadoras/$id');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
          'rut': rut,
          'contacto_apoderado': correo_contacto,
          'fecha_nacimiento': telefono_contacto,
        }));
    //agregarEducadoraNivel(niveles_id);
    return json.decode(respuesta.body);
  }

  // -------------------------------PROVIDER NIVELES--------------------
  // agregar nivel
  Future<LinkedHashMap<String, dynamic>> nivelAgregar(String nombre) async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '/Application/json'
        },
        body: jsonEncode(<String, dynamic>{'nombre': nombre}));
    return json.decode(respuesta.body);
  }

  //lista niveles
  Future<List<dynamic>> getNiveles() async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //borra un nivel
  Future<bool> nivelBorrar(int id) async {
    var uri = Uri.parse('$apiURL/niveles/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  //datos de 1 nivel
  Future<LinkedHashMap<String, dynamic>> getNivel(int id) async {
    var uri = Uri.parse('$apiURL/nivel/$id');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //editar un nivel
  Future<LinkedHashMap<String, dynamic>> nivelEditar(
      int id, String nombre) async {
    var uri = Uri.parse('$apiURL/niveles/$id');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
        }));
    //agregarEducadoraNivel(niveles_id);
    return json.decode(respuesta.body);
  }

  Future<String> getNinoNivel(String id_nino) async {
    var uri = Uri.parse('$apiURL/ninos/$id_nino/nivel');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return respuesta.body;
    } else {
      return '';
    }
  }

  Future<LinkedHashMap<String, dynamic>> ninoNivel(
      int id_nino, int id_nivel) async {
    var uri = Uri.parse('$apiURL/ninos/$id_nino/nivel');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'niveles_id': id_nivel,
        }));
    //agregarEducadoraNivel(niveles_id);
    return json.decode(respuesta.body);
  }

  Future<LinkedHashMap<String, dynamic>> educadoraNivel(
      int id_educadora, int id_nivel) async {
    var uri = Uri.parse('$apiURL/educadoranivel');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'niveles_id': id_nivel,
          'educadoras_id': id_educadora
        }));
    //agregarEducadoraNivel(niveles_id);
    return json.decode(respuesta.body);
  }

  Future<String> getEducadoraNivel(String id_educadora) async {
    var uri = Uri.parse('$apiURL/educadoras/$id_educadora/nivel');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return respuesta.body;
    } else {
      return '';
    }
  }

  Future<List<dynamic>> getNivelEducadoras(String id_nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$id_nivel/educadoras');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getNivelNinos(String id_nivel) async {
    var uri = Uri.parse('$apiURL/niveles/$id_nivel/ninos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //--------------------------PROVIDER EVENTOS------------------------
  // agregar evento
  Future<LinkedHashMap<String, dynamic>> eventoAgregar(String nombre) async {
    var uri = Uri.parse('$apiURL/niveles');
    var respuesta = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': '/Application/json'
        },
        body: jsonEncode(<String, dynamic>{'nombre': nombre}));
    return json.decode(respuesta.body);
  }

  //lista evento
  Future<List<dynamic>> getEventos() async {
    var uri = Uri.parse('$apiURL/eventos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  Future<List<dynamic>> getEventosNino(int id) async {
    var uri = Uri.parse('$apiURL/ninos/$id/eventos');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return [];
    }
  }

  //borra un evento
  Future<bool> borrarEvento(int id) async {
    var uri = Uri.parse('$apiURL/eventos/$id');
    var respuesta = await http.delete(uri);
    return respuesta.statusCode == 200;
  }

  //datos de 1 evento
  Future<LinkedHashMap<String, dynamic>> getEvento(int id) async {
    var uri = Uri.parse('$apiURL/evento/$id');
    var respuesta = await http.get(uri);

    if (respuesta.statusCode == 200) {
      return json.decode(respuesta.body);
    } else {
      return new LinkedHashMap();
    }
  }

  //editar un evento
  Future<LinkedHashMap<String, dynamic>> eventoEditar(
      int id, String nombre) async {
    var uri = Uri.parse('$apiURL/eventos/$id');
    var respuesta = await http.put(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        },
        body: jsonEncode(<String, dynamic>{
          'nombre': nombre,
        }));
    //agregarEducadoraNivel(niveles_id);
    return json.decode(respuesta.body);
  }

  //--------------------------PROVIDER IMAGEN------------------------

  postDataImagen(_data, _url) async {
    return await http.post(Uri.http('10.0.2.2:8000', _url),
        body: jsonEncode(_data),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json'
        });
  }

  Future<String> getDataImagen(ruta) async {
    ruta = '/api/imagen/1656387706.png';
    var respuesta = await http.get(Uri.http('10.0.2.2:8000', ruta));
    if (respuesta.statusCode == 200) {
      return respuesta.body;
    } else {
      return '';
    }
  }
}
