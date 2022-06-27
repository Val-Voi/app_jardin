import 'package:flutter/material.dart';
import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';

class AgregarEventoPage extends StatefulWidget {
  AgregarEventoPage({Key? key}) : super(key: key);

  @override
  State<AgregarEventoPage> createState() => _AgregarEventoPageState();
}

class _AgregarEventoPageState extends State<AgregarEventoPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          inputDecorationTheme: MyInputTheme().theme(),
        ),
        home: Scaffold(
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
