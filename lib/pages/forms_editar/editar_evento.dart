import 'package:flutter/material.dart';
import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';

class EditarEventoPage extends StatefulWidget {
  EditarEventoPage({Key? key}) : super(key: key);

  @override
  State<EditarEventoPage> createState() => _EditarEventoPageState();
}

class _EditarEventoPageState extends State<EditarEventoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: MyInputTheme().theme(),
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text('Editar Evento'),
            backgroundColor: Colors.yellow,
          ),
          body: Center(
            child: //Evento
                TextFormField(
              decoration: InputDecoration(
                labelText: "Evento Seleccionado",
                helperText: "",
                hintText: "",
              ),
            ),

            //Fin Evento,
          ),
        ));
  }
}
