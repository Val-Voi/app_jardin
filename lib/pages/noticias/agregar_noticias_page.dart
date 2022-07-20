import 'package:flutter/material.dart';
import '../../providers/jardin_provider.dart';

class AgregarNoticiasPage extends StatefulWidget {
  AgregarNoticiasPage({Key? key}) : super(key: key);

  @override
  State<AgregarNoticiasPage> createState() => _AgregarNoticiasPageState();
}

class _AgregarNoticiasPageState extends State<AgregarNoticiasPage> {
  final formKey = GlobalKey<FormState>();
  String errTitulo = '';
  String errContenido = '';

  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8), 
        child: ListView(
          children: [
            TextFormField(
              controller: tituloCtrl,
              decoration: InputDecoration(labelText: 'Titulo'),
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
            
            //alguien agrege fecha y hora no se como
            

            Container(
              width: double.infinity,
              child: ElevatedButton(
                  child: Text('Agregar'),
                  onPressed: () async {
                    var respuesta = await JardinProvider().noticiaAgregar(
                      tituloCtrl.text.trim(),
                      contenidoCtrl.text.trim(),
                    );

                    if (respuesta['messages'] != null) {
                      print('error');
                      if (respuesta['errors']['nombre'] != null) {
                        errTitulo = respuesta['errors']['nombre'][0];
                      }
                      if (respuesta['errors']['nombre'] != null) {
                        errContenido = respuesta['errors']['nombre'][0];
                      }

                      setState(() {});
                      return;
                    }
                    print('no error');
                    //  Navigator.pop(context);
                  }),
            )
          ],
        ),),
    );
  }
}