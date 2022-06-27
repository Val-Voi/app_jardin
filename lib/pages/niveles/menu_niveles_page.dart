import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MenuNivelesPage extends StatefulWidget {
  MenuNivelesPage({Key? key}) : super(key: key);

  @override
  State<MenuNivelesPage> createState() => _MenuNivelesPageState();
}

class _MenuNivelesPageState extends State<MenuNivelesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Niveles'),
        backgroundColor: Color.fromARGB(255, 136, 236, 74),
        leading: BackButton(),
      ),
      body: Text(
          'Menu de niveles, pudiendo entrar a ver lista de integrantes de ese nivel '),
    );
  }
}
