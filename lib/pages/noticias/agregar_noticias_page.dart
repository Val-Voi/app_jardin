import 'package:app_jardin/providers/firestore_provider.dart';
import 'package:flutter/material.dart';

class AgregarNoticiasPage extends StatefulWidget {
  AgregarNoticiasPage({Key? key}) : super(key: key);

  @override
  State<AgregarNoticiasPage> createState() => _AgregarNoticiasPageState();
}

class _AgregarNoticiasPageState extends State<AgregarNoticiasPage> {
  final formKey = GlobalKey<FormState>();
  String errTitulo = '';
  String errContenido = '';
  DateTime fecha = DateTime.now();
  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar Noticia'),
        backgroundColor: Color.fromARGB(255, 185, 123, 243),
        leading: BackButton(),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              TextFormField(
                controller: tituloCtrl,
                decoration: InputDecoration(labelText: 'Título'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errTitulo,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextFormField(
                controller: contenidoCtrl,
                decoration: InputDecoration(labelText: 'Contenido'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errContenido,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    child: Text('Agregar'),
                    onPressed: () {
                      FirestoreService().noticiasAgregar(
                        tituloCtrl.text.trim(),
                        contenidoCtrl.text.trim(),
                        fecha,
                      );

                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
