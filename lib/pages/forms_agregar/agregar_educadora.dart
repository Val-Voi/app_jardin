import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../providers/jardin_provider.dart';

class AgregarEducadoraPage extends StatefulWidget {
  @override
  State<AgregarEducadoraPage> createState() => _AgregarEducadoraPageState();
}

class _AgregarEducadoraPageState extends State<AgregarEducadoraPage> {
  String errNombre = '';
  String errRut = '';
  String errTelefono = '';
  String errEmail = '';
  String errNivel = '';
  String? selectedNivel;

  final _formKey = GlobalKey<FormState>();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'Nivel 1';

  // List of items in our dropdown menu
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
          child:
              ListView(padding: const EdgeInsets.all(32.0), children: <Widget>[
            // CampoNombre(),

            //NOMBRE
            TextFormField(
              controller: nombreCtrl,
              decoration: InputDecoration(
                labelText: "Nombre",
                helperText: "",
                hintText: "Ana Rodhes",
              ),
            ),

            //Fin NOMBRE

            //RUT
            TextFormField(
              controller: rutCtrl,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: InputDecoration(
                labelText: "Rut",
                helperText: "",
                hintText: "20.320.487-6",
              ),
            ),

            //Fin RUT

            //TELEFONO
            TextFormField(
              controller: telefonoCtrl,
              keyboardType:
                  TextInputType.numberWithOptions(decimal: false, signed: true),
              maxLength: 8,
              decoration: InputDecoration(
                labelText: "Telefóno",
                helperText: "",
                hintText: "",
                prefix: Text("+569"),
              ),
            ),

            //Fin TELEFONO

            //Correo
            TextFormField(
              controller: emailCtrl,
              keyboardType: TextInputType.emailAddress,
              validator: (s) {
                if (!s!.isValidEmail()) {
                  return "Ingrese Email Valido";
                }
              },
              decoration: InputDecoration(
                labelText: "E-mail",
                helperText: "",
                hintText: "email@ejemplo.com",
              ),
            ),

            //Fin correo

            //DROPDOWN DE NIVELES

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
                                //value: item['nombre'] + ' ' + item['apellido'],
                                value: item['id'].toString(),

                                // id: item['id'];
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

            //FINAL DROPDOWN DE NIVELES
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var respuesta = await JardinProvider().educadoraAgregar(
                nombreCtrl.text.trim(),
                rutCtrl.text.trim(),
                telefonoCtrl.text.trim(),
                emailCtrl.text.trim());

            if (respuesta['messages'] != null) {
              print('error');
              if (respuesta['errors']['nombre'] != null) {
                errNombre = respuesta['errors']['nombre'][0];
              }

              setState(() {});
              return;
            }
            print(respuesta);
            var respuestanivel = await JardinProvider()
                .educadoraNivel(respuesta['id'], int.parse(selectedNivel!));

            if (respuestanivel['messages'] != null) {
              print('error');
              if (respuestanivel['errors']['nombre'] != null) {
                errNombre = respuestanivel['errors']['nombre'][0];
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
