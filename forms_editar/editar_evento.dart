import 'package:flutter/material.dart';
import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';

class EditarNivelPage extends StatefulWidget {
  EditarNivelPage({Key? key}) : super(key: key);

  @override
  State<EditarNivelPage> createState() => _EditarNivelPageState();
}

class _EditarNivelPageState extends State<EditarNivelPage> {
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
