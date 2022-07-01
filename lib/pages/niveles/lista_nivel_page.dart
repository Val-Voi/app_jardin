import 'package:app_jardin/pages/educadoras/lista_educadoras_page.dart';
import 'package:app_jardin/pages/niveles/agregar_a_nivel_page.dart';
import 'package:flutter/material.dart';

import '../../providers/jardin_provider.dart';

import '../niños/lista_ninos_page_copy.dart';

class ListaNivelPage extends StatefulWidget {
  final int nivel_id;
  final String nivel_nombre;
  ListaNivelPage({Key? key, required this.nivel_id, required this.nivel_nombre})
      : super(key: key);

  @override
  State<ListaNivelPage> createState() => _ListaNivelPageState();
}

class _ListaNivelPageState extends State<ListaNivelPage> {
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
          title: Text('Integrantes de ${widget.nivel_nombre}'),
          backgroundColor: Color.fromARGB(255, 212, 146, 247),
          leading: BackButton(),
        ),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              child: Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Educadoras:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    FutureBuilder(
                      future: JardinProvider()
                          .getNivelEducadoras(widget.nivel_id.toString()),
                      builder: (context, AsyncSnapshot snap) {
                        if (!snap.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        _contadorColor = 0;

                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => Divider(),
                          itemCount: snap.data.length,
                          itemBuilder: (context, index) {
                            var educadora = snap.data[index];
                            return Center(
                                child: Card(
                              color: color(),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          '${educadora['nombre']}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 'datos',
                                              child: Text('Ver datos'),
                                            ),
                                            // PopupMenuItem(
                                            //   value: 'nivel',
                                            //   child: Text('Cambiar de Nivel'),
                                            // ), //TODO: redirigir a pagina para cambiar de nivel
                                          ],
                                          onSelected: (opcion) {
                                            if (opcion == 'nivel') {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    AgregarANivelPage(),
                                              );
                                              Navigator.push(context, route);
                                            } else if (opcion == 'datos') {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    ListaEducadorasPage(
                                                        educadoraBuscar:
                                                            educadora[
                                                                'nombre']),
                                              );
                                              Navigator.push(context, route);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ));
                          },
                        );
                      },
                    ),
                    // Divider(
                    //   height: 50,
                    // ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Center(
                          child: Text(
                        'Niños:',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      )),
                    ),
                    FutureBuilder(
                      future: JardinProvider()
                          .getNivelNinos(widget.nivel_id.toString()),
                      builder: (context, AsyncSnapshot snap) {
                        if (!snap.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        _contadorColor = 0;

                        return ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          separatorBuilder: (_, __) => Divider(),
                          itemCount: snap.data.length,
                          itemBuilder: (context, index) {
                            var nino = snap.data[index];
                            return Center(
                                child: Card(
                              color: color(),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                          '${nino['nombre']} ${nino['apellido']}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        trailing: PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 'datos',
                                              child: Text('Ver Datos'),
                                            ),
                                            PopupMenuItem(
                                              value: 'nivel',
                                              child: Text('Cambiar de Nivel'),
                                            ),
                                          ],
                                          onSelected: (opcion) {
                                            if (opcion == 'nivel') {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    AgregarANivelPage(),
                                              );
                                              Navigator.push(context, route);
                                            } else if (opcion == 'datos') {
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) =>
                                                    ListaNinosPage(
                                                        ninoBuscar:
                                                            nino['apellido']),
                                              );
                                              Navigator.push(context, route);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ));
                          },
                        );
                      },
                    ),
                  ],
                ),
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
