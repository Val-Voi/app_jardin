import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';
import 'package:flutter/material.dart';
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

  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController contactoCtrl = TextEditingController();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  TextEditingController fechaNacCtrl = TextEditingController();
  // valor inicial
  String dropdownvalue = 'Nivel 1';

  // Lista de items
  var items = [
    'Nivel 1',
    'Nivel 2',
    'Nivel 3',
    'Nivel 4',
    'Nivel 5',
  ];

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
              // CampoNombre(),

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
                controller: rutCtrl,
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
            ]
                .map((child) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: child,
                    ))
                .toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var respuesta = await JardinProvider().ninoAgregar(
                nombreCtrl.text.trim(),
                apellidoCtrl.text.trim(),
                rutCtrl.text.trim(),
                nivelCtrl.text.trim());
            //fechaNacCtrl.text.trim());

//                 nombreCtrl
// apellidoCtrl
// contactoCtrl
// rutCtrl
// nivelCtrl
// fechaNacCtrl

            if (respuesta['messages'] != null) {
              print('error');
              if (respuesta['errors']['nombre'] != null) {
                errNombre = respuesta['errors']['nombre'][0];
              }

              setState(() {});
              return;
            }
            print('no error');
            // final valido = _formKey.currentState!.validate();
            // print('Todo bien: $valido');
          },
          child: Icon(MdiIcons.contentSave),
        ),
      ),
    );
  }
}
