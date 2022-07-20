import 'package:app_jardin/pages/noticias/agregar_noticias_page.dart';
import 'package:app_jardin/pages/noticias/editar_noticias_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../providers/firestore_provider.dart';

class ListaNoticiaPage extends StatefulWidget {
  ListaNoticiaPage({Key? key}) : super(key: key);

  @override
  State<ListaNoticiaPage> createState() => _ListaNoticiaPageState();
}

class _ListaNoticiaPageState extends State<ListaNoticiaPage> {
  final DateFormat formatoFecha = DateFormat('dd-MM-yyyy');
  final DateFormat formatoHora = DateFormat('HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Noticias'),
        backgroundColor: Color.fromARGB(255, 185, 123, 243),
        leading: BackButton(),
        actions: [
          IconButton(
              onPressed: () {
                MaterialPageRoute route = MaterialPageRoute(
                  builder: (context) => AgregarNoticiasPage(),
                );
                Navigator.push(context, route);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: Column(
        children: [
          Divider(),
          Expanded(
            child: StreamBuilder(
              stream: FirestoreService().noticias(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var noticia = snapshot.data!.docs[index];
                    var fecha = formatoFecha.format(noticia['fecha'].toDate());
                    var hora = formatoHora.format(noticia['fecha'].toDate());

                    return ListTile(
                      title: Text('${noticia['titulo']}\n'),
                      subtitle: Text(
                          '${noticia['contenido']} \n\nFecha: ${fecha} ${hora}'),
                      trailing: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              MdiIcons.fileEdit,
                              color: Color.fromARGB(255, 255, 90, 90),
                            ),
                            onPressed: () {
                              // print(noticia.id);
                              MaterialPageRoute route = MaterialPageRoute(
                                builder: (context) =>
                                    EditarNoticiaPage(noticia.id.toString()),
                              );
                              Navigator.push(context, route);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              MdiIcons.trashCan,
                              color: Color.fromARGB(255, 255, 90, 90),
                            ),
                            onPressed: () {
                              // print(noticia.id);
                              FirestoreService().noticiasBorrar(noticia.id);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
