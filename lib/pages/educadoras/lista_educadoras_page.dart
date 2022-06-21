import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListaEducadorasPage extends StatefulWidget {
  ListaEducadorasPage({Key? key}) : super(key: key);

  @override
  State<ListaEducadorasPage> createState() => _ListaEducadorasPageState();
}

class _ListaEducadorasPageState extends State<ListaEducadorasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardin App'),
        backgroundColor: Color.fromARGB(255, 136, 236, 74),
        leading: Icon(MdiIcons.humanChild),
      ),
      body: Text('Lista Educadoras con editar y borrar'),
    );
  }
}
