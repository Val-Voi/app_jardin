import 'package:app_jardin/pages/forms_editar/editar_evento.dart';
import 'package:app_jardin/pages/main_page_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../providers/jardin_provider.dart';

class EventosNinoPage extends StatefulWidget {
  final int id_nino;
  final String nino_nombre;
  final Color color;
  EventosNinoPage(
      {Key? key,
      required this.id_nino,
      required this.color,
      required this.nino_nombre})
      : super(key: key);

  @override
  State<EventosNinoPage> createState() => _EventosNinoPageState();
}

class _EventosNinoPageState extends State<EventosNinoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Eventos de: ${widget.nino_nombre}'),
          backgroundColor: Color.fromARGB(255, 185, 123, 243),
          leading: BackButton(),
          actions: [
            // IconButton(
            //   icon: Icon(Icons.add),
            //   onPressed: () {
            //     MaterialPageRoute route = MaterialPageRoute(
            //       builder: (context) =>
            //           MainPage(), //TODO: REDIRIGIR A PAGINA DE AGREGAR EVENTO CON ID DE NIÑO
            //     );
            //     Navigator.push(context, route);
            //   },
            // ),
          ],
        ),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: JardinProvider().getEventosNino(widget.id_nino),
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
                            var evento = snap.data[index];
                            return Center(
                              child: Card(
                                color: widget.color,
                                child: Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                          '${evento['descripcion']}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          '${evento['fecha']}',
                                          style: TextStyle(
                                            fontSize: 16.0,
                                          ),
                                        ),
                                        trailing: PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 'editar',
                                              child: Text('Editar'),
                                            ),
                                            PopupMenuItem(
                                              value: 'borrar',
                                              child: Text('Borrar'),
                                            ),
                                          ],
                                          onSelected: (opcion) {
                                            if (opcion == 'editar') {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    EditarEventoPage(), //TODO: REDIRIGIR A PAGINA DE EDITAR EVENTO
                                              );
                                              Navigator.push(context, route);
                                            } else if (opcion == 'borrar') {
                                              int evento_id = evento['id'];

                                              JardinProvider()
                                                  .borrarEvento(evento_id)
                                                  .then((borradoOk) {
                                                if (borradoOk) {
                                                  //pudo borrar
                                                  snap.data.removeAt(index);
                                                  setState(() {});

                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      duration:
                                                          Duration(seconds: 4),
                                                      content: Text(
                                                        'Evento borrado',
                                                        style: TextStyle(
                                                            fontSize: 16),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  //no pudo borrar
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      duration:
                                                          Duration(seconds: 4),
                                                      content: Text(
                                                          'El evento no se pudo borrar'),
                                                    ),
                                                  );
                                                }
                                              });
                                            }
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            )));
  }
}
