import 'dart:convert';
import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../providers/jardin_provider.dart';

class AgregarEventoPage extends StatefulWidget {
  AgregarEventoPage({Key? key}) : super(key: key);

  @override
  State<AgregarEventoPage> createState() => _AgregarEventoPageState();
}

class _AgregarEventoPageState extends State<AgregarEventoPage> {
  final _formKey = GlobalKey<FormState>();
  DateTime fechaSeleccionada = DateTime.now();
  var ffecha = DateFormat('dd-MM-yyyy');

  /// la fecha en formato español el programa no la tomaba
  String errNombre = '';
  String errRut = '';
  String errContacto = '';
  String errApellido = '';
  String errNivel = '';
  String? selectedNino;

  TextEditingController descripcionCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController contactoCtrl = TextEditingController();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  TextEditingController fechaNacCtrl = TextEditingController();
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

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
              TextFormField(
                controller: descripcionCtrl,
                decoration: InputDecoration(
                  labelText: "Descripción",
                  helperText: "",
                  hintText: " ",
                ),
              ),
              Row(
                children: [
                  Text('Fecha: ', style: TextStyle(fontSize: 16)),
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
                  future: JardinProvider().getNinos(),
                  builder: (context, AsyncSnapshot snap) {
                    if (!snap.hasData) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    List ninos = snap.data;
                    return DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        isExpanded: true,
                        hint: Text(
                          'Seleccionar niño',
                          style: TextStyle(
                            fontSize: 14,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                        items: ninos
                            .map((item) => DropdownMenuItem<String>(
                                  //value: item['nombre'] + ' ' + item['apellido'],
                                  value: item['id'].toString(),

                                  // id: item['id'];
                                  child: Text(
                                    item['nombre'] + ' ' + item['apellido'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        value: selectedNino,
                        onChanged: (value) {
                          setState(() {
                            selectedNino = value as String;
                            print(selectedNino);
                          });
                        },
                        buttonHeight: 40,
                        buttonWidth: 200,
                        itemHeight: 40,
                        dropdownMaxHeight: 200,
                        searchController: textEditingController,
                        searchInnerWidget: Padding(
                          padding: const EdgeInsets.only(
                            top: 8,
                            bottom: 4,
                            right: 8,
                            left: 8,
                          ),
                          child: TextFormField(
                            controller: textEditingController,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              hintText: 'Nombre',
                              hintStyle: const TextStyle(fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        searchMatchFn: (item, searchValue) {
                          return (item.child
                              .toString()
                              .toLowerCase()
                              .contains(searchValue.toLowerCase()));
                        },
                        //This to clear the search value when you close the menu
                        onMenuStateChange: (isOpen) {
                          if (!isOpen) {
                            textEditingController.clear();
                          }
                        },
                      ),
                    );
                  }),
              ElevatedButton(
                onPressed: () async {
                  String nombreImagen =
                      DateTime.now().millisecondsSinceEpoch.toString() + '.png';
                  var respuesta = await JardinProvider().eventoAgregar(
                    descripcionCtrl.text.trim(),
                    fechaSeleccionada.toString(),
                    int.tryParse(selectedNino!) ?? 1,
                  );

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
                child: Text('Guardar Evento'),
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
