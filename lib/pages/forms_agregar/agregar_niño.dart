import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AgregarNinoPage extends StatefulWidget {
  AgregarNinoPage({Key? key}) : super(key: key);

  @override
  State<AgregarNinoPage> createState() => _AgregarNinoPageState();
}

class _AgregarNinoPageState extends State<AgregarNinoPage> {
  final _formKey = GlobalKey<FormState>();
  // late DateTime _dateTime;

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
                decoration: InputDecoration(
                  labelText: "Nombre",
                  helperText: "",
                  hintText: "Juanito Tft",
                ),
              ),

              //Fin NOMBRE

              //RUT
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  labelText: "Rut",
                  helperText: "",
                  hintText: "20.320.487-6",
                ),
              ),

              //Fin RUT

              //FECHA NAC
              //  Text(_dateTime == null ? 'No se ha seleccionado nada': _dateTime.toString())
              //  showDatePicker(
              //   context: context,
              //   initialDate: DateTime.now(),
              //   firstDate: DateTime(2001),
              //   lastDate: DateTime(2022)
              //  ).then((date){
              //   setState(() {
              //                _dateTime = date;
              //                 });
              //  })

              //Fin fehca nac
            ]
                .map((child) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: child,
                    ))
                .toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final valido = _formKey.currentState!.validate();
            print('Todo bien: $valido');
          },
          child: Icon(MdiIcons.contentSave),
        ),
      ),
    );
  }
}
