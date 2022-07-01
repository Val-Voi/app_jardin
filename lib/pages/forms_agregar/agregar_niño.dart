import 'dart:convert';
import 'dart:io';

import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../providers/jardin_provider.dart';

class AgregarNinoPage extends StatefulWidget {
  AgregarNinoPage({Key? key}) : super(key: key);

  @override
  State<AgregarNinoPage> createState() => _AgregarNinoPageState();
}

class _AgregarNinoPageState extends State<AgregarNinoPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime fechaSeleccionada = DateTime.now();
  var ffecha = DateFormat('dd-MM-yyyy');

  /// la fecha en formato español el programa no la tomaba
  String errNombre = '';
  String errRut = '';
  String errContacto = '';
  String errApellido = '';
  String errNivel = '';
  String selectedNivel = '1';
  String? _ruta;
  String? _image64;
  String cargaImagen = 'Cargar imagen';
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController contactoCtrl = TextEditingController();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  TextEditingController fechaNacCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: MyInputTheme().theme(),
      ),
      home: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(32.0),
            children: <Widget>[
              //NOMBRE
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(
                  labelText: "Nombre",
                  helperText: "",
                  hintText: "Juan",
                ),
              ),

              //Fin NOMBRE

              //APELLIDO
              TextFormField(
                controller: apellidoCtrl,
                decoration: InputDecoration(
                  labelText: "Apellido",
                  helperText: "",
                  hintText: "Gonzales",
                ),
              ),

              //APELLIDO

              //RUT
              TextFormField(
                controller: rutCtrl,
                keyboardType: TextInputType.numberWithOptions(),
                maxLength: 12,
                decoration: InputDecoration(
                  labelText: "Rut",
                  helperText: "",
                  hintText: "20.320.487-6",
                ),
              ),

              //Fin RUT

              //Contacto
              TextFormField(
                controller: contactoCtrl,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: false, signed: true),
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: "Número de contacto",
                  helperText: "",
                  hintText: "xxxxxxxx",
                  prefix: Text("+569"),
                ),
              ),

              //fin contacto

              Row(
                children: [
                  Text('Fecha de nacimiento:', style: TextStyle(fontSize: 16)),
                  Text(ffecha.format(fechaSeleccionada),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Spacer(),
                  TextButton(
                    child: Icon(MdiIcons.calendar),
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1920),
                        lastDate: DateTime.now(),
                      ).then((fecha) {
                        setState(() {
                          // fechaSeleccionada = fecha != null ? fecha : fechaSeleccionada;
                          fechaSeleccionada = fecha ?? fechaSeleccionada;
                        });
                      });
                    },
                  ),
                ],
              ),
              FutureBuilder(
                  future: JardinProvider().getNiveles(),
                  builder: (context, AsyncSnapshot snap) {
                    if (!snap.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List niveles = snap.data;
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          'Seleccionar nivel',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: niveles
                            .map((item) => DropdownMenuItem<String>(
                                  value: item['id'].toString(),
                                  child: Text(
                                    item['nombre'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedNivel,
                        onChanged: (value) {
                          setState(() {
                            selectedNivel = value as String;
                            print(selectedNivel);
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 200,
                        itemHeight: 40,
                        dropdownMaxHeight: 200,
                      ),
                    );
                  }),

              Row(
                children: [
                  (_ruta == null)
                      ? Container()
                      : Image.file(
                          File(_ruta!),
                          width: 200,
                        ),
                  ElevatedButton(
                      child: Text(cargaImagen),
                      onPressed: () async {
                        final XFile? _archivo = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        cargaImagen = 'Cambiar Imagen';
                        setState(() {
                          _ruta = _archivo!.path;
                        });
                        _image64 = base64
                            .encode(await new File(_ruta!).readAsBytesSync());
                      }),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  String nombreImagen =
                      DateTime.now().millisecondsSinceEpoch.toString() + '.png';
                  var respuesta = await JardinProvider().ninoAgregar(
                    nombreCtrl.text.trim(),
                    apellidoCtrl.text.trim(),
                    fechaSeleccionada.toString(),
                    rutCtrl.text.trim(),
                    contactoCtrl.text.trim(),
                    int.tryParse(selectedNivel) ?? 1,
                    nombreImagen,
                  );

                  var data = {'imagen': _image64, 'nombre': nombreImagen};
                  var respuestaImagen = await JardinProvider()
                      .postDataImagen(data, "/api/imagen");

                  var contenido = json.decode(respuestaImagen.body);

                  if (respuesta['messages'] != null) {
                    print('error');
                    if (respuesta['errors']['nombre'] != null) {
                      errNombre = respuesta['errors']['nombre'][0];
                    }
                    if (respuesta['errors']['nivel'] != null) {
                      errNivel = respuesta['errors']['nivel'][0];
                    }

                    setState(() {});
                    return;
                  }
                  print('no error');
                },
                child: Text('Guardar Niño'),
              ),
            ]
                .map((child) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: child,
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
