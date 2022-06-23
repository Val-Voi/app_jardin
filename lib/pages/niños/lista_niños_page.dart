import 'package:app_jardin/pages/main_page_page.dart';
import 'package:app_jardin/providers/jardin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:app_jardin/main.dart';

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
        leading: BackButton(),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: JardinProvider().getNinos(),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      var nino = snap.data[index];
                      return Slidable(
                        child: ListTile(
                          leading: Icon(MdiIcons.humanChild),
                          title: Text('[${nino['id']}] ${nino['nombre']}'),
                          subtitle: Text('RUT: ${nino['rut']}'),
                        ),
                        startActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                MaterialPageRoute route = MaterialPageRoute(
                                  builder: (context) => MainPage(),
                                );
                                Navigator.push(context, route).then((value) {
                                  setState(() {});
                                });
                              },
                              backgroundColor: Colors.purple,
                              icon: MdiIcons.pen,
                              label: 'Editar',
                            ),
                          ],
                        ),
                        endActionPane: ActionPane(
                          motion: ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                String id_nino = nino['id'];
                                String nombre = nino['nombre'];

                                // confirmDialog(context, nombre).then((confirma) {
                                //   if (confirma) {
                                //     //borrar
                                //     JardinProvider().ninoBorrar(id_nino).then((borradoOk) {
                                //       if (borradoOk) {
                                //         //pudo borrar
                                //         snap.data.removeAt(index);
                                //         setState(() {});

                                //         showSnackbar('Nino $nombre borrado');
                                //       } else {
                                //         //no pudo borrar
                                //         showSnackbar('No se pudo borrar el producto');
                                //       }
                                //     });
                                //   }
                                // });
                              },
                              backgroundColor: Colors.red,
                              icon: MdiIcons.trashCan,
                              label: 'Borrar',
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
      ),
    );
  }
}
