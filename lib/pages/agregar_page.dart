import 'package:app_jardin/providers/jardin_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AgregarPage extends StatefulWidget {
  AgregarPage({Key? key}) : super(key: key);

  @override
  State<AgregarPage> createState() => _AgregarPageState();
}

class _AgregarPageState extends State<AgregarPage> {
  final formKey = GlobalKey<FormState>();

  TextEditingController nombreCtrl = TextEditingController();

  String errNombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardin App'),
        backgroundColor: Color.fromARGB(255, 136, 236, 74),
        leading: Icon(MdiIcons.humanChild),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              TextFormField(
                controller: nombreCtrl,
                decoration: InputDecoration(labelText: 'Nombre'),
              ),
              Container(
                width: double.infinity,
                child: Text(
                  errNombre,
                  style: TextStyle(color: Colors.red),
                ),
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                    child: Text('Agregar'),
                    onPressed: () async {
                      var respuesta = await JardinProvider().jardinAgregar(
                        nombreCtrl.text.trim(),
                      );

                      if (respuesta['messages'] != null) {
                        print('error');
                        if (respuesta['errors']['nombre'] != null) {
                          errNombre = respuesta['errors']['nombre'][0];
                        }

                        setState(() {});
                        return;
                      }
                      print('no error');
                      //  Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
