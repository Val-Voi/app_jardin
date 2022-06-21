import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ListaNinosPage extends StatefulWidget {
  ListaNinosPage({Key? key}) : super(key: key);

  @override
  State<ListaNinosPage> createState() => _ListaNinosPageState();
}

class _ListaNinosPageState extends State<ListaNinosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardin App'),
        backgroundColor: Color.fromARGB(255, 136, 236, 74),
        leading: Icon(MdiIcons.humanChild),
      ),
      body: Text('Lista Niños con editar, borrar y ver eventos'),
    );
  }
}
