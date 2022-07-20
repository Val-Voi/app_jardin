import 'package:flutter/material.dart';

class AgregarNoticiasPage extends StatefulWidget {
  AgregarNoticiasPage({Key? key}) : super(key: key);

  @override
  State<AgregarNoticiasPage> createState() => _AgregarNoticiasPageState();
}

class _AgregarNoticiasPageState extends State<AgregarNoticiasPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8), 
        child: ListView(
          
        ),),
    );
  }
}