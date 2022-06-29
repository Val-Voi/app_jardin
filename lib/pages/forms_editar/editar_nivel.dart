import 'package:app_jardin/providers/jardin_provider.dart';
import 'package:flutter/material.dart';

class EditarNivelPage extends StatefulWidget {
  int idNivel;
  EditarNivelPage(this.idNivel, {Key? key}) : super(key: key);

  @override
  State<EditarNivelPage> createState() => _EditarNivelPageState();
}

class _EditarNivelPageState extends State<EditarNivelPage> {
  TextEditingController nombreCtrl = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Nivel'),
          backgroundColor: Color.fromARGB(255, 212, 146, 247),
          leading: BackButton(),
        ),
        body: FutureBuilder(
          future: JardinProvider().getNivel(widget.idNivel),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data;
            nombreCtrl.text = data['nombre'];

            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: nombreCtrl,
                    decoration: InputDecoration(labelText: 'Nombre nivel'),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        JardinProvider().nivelEditar(
                          widget.idNivel,
                          nombreCtrl.text.trim(),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
