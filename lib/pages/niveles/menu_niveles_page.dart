import 'package:app_jardin/pages/main_page_page.dart';
import 'package:flutter/material.dart';
import 'package:app_jardin/pages/forms_editar/editar_nivel.dart';
import '../../providers/jardin_provider.dart';

class MenuNivelesPage extends StatefulWidget {
  MenuNivelesPage({Key? key}) : super(key: key);

  @override
  State<MenuNivelesPage> createState() => _MenuNivelesPageState();
}

class _MenuNivelesPageState extends State<MenuNivelesPage> {
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
          title: Text('Lista de Niveles'),
          backgroundColor: Color.fromARGB(255, 212, 146, 247),
          leading: BackButton(),
        ),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              child: Column(
                children: [
                  Expanded(
                    child: FutureBuilder(
                      future: JardinProvider().getNiveles(),
                      builder: (context, AsyncSnapshot snap) {
                        if (!snap.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        _contadorColor = 0;

                        return ListView.separated(
                          separatorBuilder: (_, __) => Divider(),
                          itemCount: snap.data.length,
                          itemBuilder: (context, index) {
                            var nivel = snap.data[index];
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
                                          '${nivel['nombre']}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FutureBuilder(
                                                future: JardinProvider()
                                                    .getNivelEducadoras(
                                                        nivel['id'].toString()),
                                                builder: (context,
                                                    AsyncSnapshot snapninos) {
                                                  if (!snapninos.hasData) {
                                                    return CircularProgressIndicator(
                                                        // 'Nivel sin educadoras',
                                                        // style: TextStyle(
                                                        //   color: Colors.white,
                                                        //   fontSize: 16.0,
                                                        // ),
                                                        );
                                                  }

                                                  return Text(
                                                    'Educadoras: ${snapninos.data.length}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  );
                                                }),
                                            FutureBuilder(
                                                future: JardinProvider()
                                                    .getNivelNinos(
                                                        nivel['id'].toString()),
                                                builder: (context,
                                                    AsyncSnapshot snapninos) {
                                                  if (!snapninos.hasData) {
                                                    return CircularProgressIndicator(
                                                        // 'Nivel sin niños',
                                                        // style: TextStyle(
                                                        //   color: Colors.white,
                                                        //   fontSize: 16.0,
                                                        // ),
                                                        );
                                                  }

                                                  return Text(
                                                    'Niños: ${snapninos.data.length}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16.0,
                                                    ),
                                                  );
                                                }),
                                          ],
                                        ),
                                        trailing: PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                              value: 'integrantes',
                                              child: Text('Ver Integrantes'),
                                            ),
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
                                                          EditarNivelPage(nivel['id']),
                                                    );
                                                    Navigator.push(
                                                        context, route);
                                            } else if (opcion ==
                                                'integrantes') {
                                              int nivel_id = nivel['id'];
                                              String nivel_nombre =
                                                  nivel['nombre'];
                                              MaterialPageRoute route =
                                                  MaterialPageRoute(
                                                builder: (context) => MainPage(
                                                    // id_nivel: nivel_id,
                                                    // nivel_nombre: nivel_nombre,
                                                    ),
                                              );
                                              Navigator.push(context, route);
                                            } else if (opcion == 'borrar') {
                                              int nivel_id = nivel['id'];
                                              JardinProvider()
                                                  .nivelBorrar(nivel_id)
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
                                                        'Nivel ${nivel['nombre']} borrado',
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
                                                          'El nivel no se pudo borrar'),
                                                    ),
                                                  );
                                                }
                                              });
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
