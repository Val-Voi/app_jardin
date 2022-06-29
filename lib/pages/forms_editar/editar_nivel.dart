import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EditarNivelPage extends StatefulWidget {
  EditarNivelPage({Key? key}) : super(key: key);

  @override
  State<EditarNivelPage> createState() => _EditarNivelPageState();
}

class _EditarNivelPageState extends State<EditarNivelPage> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardin App'),
        backgroundColor: Color.fromARGB(255, 212, 146, 247),
        leading: BackButton(),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(32),
          children: [

            // Nombre del Nivel
            TextFormField(
                decoration: InputDecoration(
                  labelText: "Nombre",
                  helperText: "",
                  hintText: "Ingrese nivel",
                ),
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
        onPressed: () {
          final valido = _formKey.currentState!.validate();
          print('Todo bien: $valido');
        },
        child: Icon(MdiIcons.contentSave),
      ),
    );
  }
}
