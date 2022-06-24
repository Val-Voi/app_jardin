import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AgregarANivelPage extends StatefulWidget {
  AgregarANivelPage({Key? key}) : super(key: key);

  @override
  State<AgregarANivelPage> createState() => _AgregarANivelPageState();
}

class _AgregarANivelPageState extends State<AgregarANivelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardin App'),
        backgroundColor: Color.fromARGB(255, 136, 236, 74),
        leading: BackButton(),
      ),
      body: Text('Formulario para agregar niño/educadora a un nivel'),
    );
  }
}
