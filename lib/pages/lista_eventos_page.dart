import 'package:flutter/material.dart';
import '../providers/jardin_provider.dart';
import 'forms_editar/editar_evento.dart';

class ListaEventosPage extends StatefulWidget {
  ListaEventosPage({Key? key}) : super(key: key);

  @override
  State<ListaEventosPage> createState() => _ListaEventosPageState();
}

class _ListaEventosPageState extends State<ListaEventosPage> {
  int _contadorColor = 0;
  List<Color> colores = [
    Color.fromARGB(255, 104, 228, 193),
    Color.fromARGB(255, 244, 173, 102),
    Color.fromARGB(255, 235, 93, 127),
    Color.fromARGB(255, 185, 123, 243),
    Color.fromARGB(255, 130, 192, 241),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de Eventos'),
          backgroundColor: Color.fromARGB(255, 185, 123, 243),
          leading: BackButton(),
        ),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: JardinProvider().getEventos(),
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
                                color: color(),
                                child: Column(
                                  children: [
                                    ListTile(
                                        title: Text(
                                          '${evento['descripcion']}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Divider(
                                              thickness: 1,
                                              color: Colors.black,
                                            ),
                                            Text(
                                              'Fecha: ${evento['fecha']}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                            FutureBuilder(
                                                future: JardinProvider()
                                                    .getEventoNino(evento['id']
                                                        .toString()),
                                                builder: (context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return Text(
                                                      'Evento sin niño',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                      ),
                                                    );
                                                  }

                                                  return Text(
                                                    'Niño: ${snapshot.data}',
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16.0,
                                                    ),
                                                  );
                                                }),
                                          ],
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

  Color color() {
    _contadorColor++;
    if (_contadorColor >= 5) {
      _contadorColor = 0;
    }
    return colores[_contadorColor];
  }
}
