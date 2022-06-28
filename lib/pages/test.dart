import 'package:app_jardin/providers/jardin_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class pagina extends StatefulWidget {
  @override
  _paginaState createState() => _paginaState();
}

class _paginaState extends State<pagina> {
  String? _ruta;
  String? _image64;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            (_ruta == null)
                ? Container()
                : Image.file(
                    File(_ruta!),
                    width: 200,
                  ),
            ElevatedButton(
                child: Text("CARGAR IMAGEN"),
                onPressed: () async {
                  final XFile? _archivo = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);

                  setState(() {
                    _ruta = _archivo!.path;
                  });
                  _image64 =
                      base64.encode(await new File(_ruta!).readAsBytesSync());
                }),

            /// enviar al servidor web
            ElevatedButton(
                child: Text("ENVIAR AL SERVIDOR"),
                onPressed: () {
                  _enviarform();
                })
          ],
        ),
      ),
    );
  }

  void _enviarform() async {
    var data = {'imagen': _image64};
    var respuesta = await JardinProvider().postDataImagen(data, "/api/imagen");
    var contenido = json.decode(respuesta.body);
    return contenido;
  }
}
