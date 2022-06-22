import 'package:flutter/material.dart';
import '../../providers/jardin_provider.dart';

class AgregarNivel extends StatefulWidget {
  AgregarNivel({Key? key}) : super(key: key);

  @override
  State<AgregarNivel> createState() => _AgregarNivelState();
}

class _AgregarNivelState extends State<AgregarNivel> {
  String errNombre = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
    );
  }
}
