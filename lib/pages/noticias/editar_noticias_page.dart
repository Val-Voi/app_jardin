import 'package:app_jardin/providers/jardin_provider.dart';
import 'package:flutter/material.dart';

class EditarNoticiaPage extends StatefulWidget {
  int idNoticia;
  EditarNoticiaPage(this.idNoticia, {Key? key}) : super(key: key);

  @override
  State<EditarNoticiaPage> createState() => _EditarNoticiaPageState();
}

class _EditarNoticiaPageState extends State<EditarNoticiaPage> {

  TextEditingController tituloCtrl = TextEditingController();
  TextEditingController contenidoCtrl= TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Editar Noticia'),
          backgroundColor: Color.fromARGB(255, 130, 192, 241),
          leading: BackButton(),
        ),
      body: FutureBuilder(
          future: JardinProvider().getNoticia(widget.idNoticia),
          builder: (context, AsyncSnapshot snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            var data = snapshot.data;
            tituloCtrl.text = data['titulo'];
            contenidoCtrl.text = data['contenido'];

            return Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    controller: tituloCtrl,
                    decoration: InputDecoration(labelText: 'Titulo'),
                  ),
                  TextField(
                    controller: contenidoCtrl,
                    decoration: InputDecoration(labelText: 'Contenido'),
                  ),
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      child: Text('Editar'),
                      onPressed: () {
                        JardinProvider().noticiaEditar(
                          widget.idNoticia,
                          tituloCtrl.text.trim(),
                          contenidoCtrl.text.trim(),
                        );
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }
}