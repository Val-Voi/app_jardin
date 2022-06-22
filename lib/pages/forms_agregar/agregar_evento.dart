import 'package:flutter/material.dart';

class AgregarEvento extends StatefulWidget {
  AgregarEvento({Key? key}) : super(key: key);

  @override
  State<AgregarEvento> createState() => _AgregarEventoState();
}

class _AgregarEventoState extends State<AgregarEvento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Formulario Evento'),
    );
  }
}
