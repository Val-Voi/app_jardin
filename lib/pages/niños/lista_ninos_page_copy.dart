import 'dart:convert';
import 'dart:io' as Io;
import 'dart:typed_data';
import 'package:app_jardin/pages/forms_editar/editar_ni%C3%B1o.dart';
import 'package:app_jardin/providers/jardin_provider.dart';
import 'package:flutter/material.dart';
import 'eventos_niño_page.dart';

class ListaNinosPage extends StatefulWidget {
  final String ninoBuscar;
  ListaNinosPage({Key? key, this.ninoBuscar: ''}) : super(key: key);

  @override
  State<ListaNinosPage> createState() => _ListaNinosPageState();
}

class _ListaNinosPageState extends State<ListaNinosPage> {
  int _contadorColor = 0;
  List<Color> colores = [
    Color.fromARGB(255, 104, 228, 193),
    Color.fromARGB(255, 244, 173, 102),
    Color.fromARGB(255, 235, 93, 127),
    Color.fromARGB(255, 185, 123, 243),
    Color.fromARGB(255, 130, 192, 241),
  ];
  String buscarNino = "";
  TextEditingController _controller = TextEditingController(text: '');
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => buscarDefault());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista Niños'),
          backgroundColor: Color.fromARGB(255, 212, 146, 247),
          leading: BackButton(),
        ),
        body: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _controller.text = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Buscar niño',
                        suffixIcon: Icon(Icons.search)),
                  ),
                  Expanded(
                    child: FutureBuilder(
                      future: JardinProvider().getNinos(),
                      builder: (context, AsyncSnapshot snap) {
                        if (!snap.hasData) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        _contadorColor = 0;

                        return ListView.separated(
                          separatorBuilder: (BuildContext context, int index) {
                            return snap.data![index]['nombre']
                                        .toLowerCase()
                                        .contains(
                                            _controller.text.toLowerCase()) ||
                                    snap.data![index]['apellido']
                                        .toLowerCase()
                                        .contains(
                                            _controller.text.toLowerCase())
                                ? Divider()
                                : Container();
                          },
                          itemCount: snap.data.length,
                          itemBuilder: (context, index) {
                            var nino = snap.data[index];
                            return snap.data![index]['nombre']
                                        .toLowerCase()
                                        .contains(
                                            _controller.text.toLowerCase()) ||
                                    snap.data![index]['apellido']
                                        .toLowerCase()
                                        .contains(
                                            _controller.text.toLowerCase())
                                ? Center(
                                    child: Card(
                                    color: color(),
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 100,
                                          alignment: Alignment.center,
                                          child: FutureBuilder(
                                            future: JardinProvider()
                                                .getDataImagen(nino['imagen']),
                                            builder: (context,
                                                AsyncSnapshot<String>
                                                    snapimagen) {
                                              if (!snapimagen.hasData) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (snapimagen
                                                          .data!.length %
                                                      4 ==
                                                  0) {
                                                Uint8List imgdecoded =
                                                    base64Decode(snapimagen.data
                                                        .toString()
                                                        .split('\n')
                                                        .join());
                                                ImageProvider imagen =
                                                    Image.memory(imgdecoded)
                                                        .image;
                                                return CircleAvatar(
                                                  radius: 50,
                                                  backgroundImage: imagen,
                                                );
                                              } else {
                                                //print(snapimagen.data!.length);
                                                return Text('no imagen');
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                            child: Column(
                                          children: [
                                            ListTile(
                                              title: Text(
                                                '${nino['nombre']} ${nino['apellido']}',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              subtitle: FutureBuilder(
                                                  future: JardinProvider()
                                                      .getNinoNivel(nino['id']
                                                          .toString()),
                                                  builder: (context, snapshot) {
                                                    if (!snapshot.hasData) {
                                                      return Text(
                                                        'Niño sin nivel',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0,
                                                        ),
                                                      );
                                                    }
                                                    return Text(
                                                      'Nivel ${snapshot.data}',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16.0,
                                                      ),
                                                    );
                                                  }),
                                              trailing: PopupMenuButton(
                                                itemBuilder: (context) => [
                                                  PopupMenuItem(
                                                    value: 'eventos',
                                                    child: Text('Ver Eventos'),
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
                                                          EditarNinoPage(
                                                              id: nino['id'],
                                                              nivel_actual: nino[
                                                                      'nivel_id']
                                                                  .toString()),
                                                    );
                                                    Navigator.push(
                                                        context, route);
                                                  } else if (opcion ==
                                                      'eventos') {
                                                    int nino_id = nino['id'];
                                                    String nino_nombre =
                                                        nino['nombre'] +
                                                            ' ' +
                                                            nino['apellido'];
                                                    MaterialPageRoute route =
                                                        MaterialPageRoute(
                                                      builder: (context) =>
                                                          EventosNinoPage(
                                                        color: color(),
                                                        id_nino: nino_id,
                                                        nino_nombre:
                                                            nino_nombre,
                                                      ),
                                                    );
                                                    Navigator.push(
                                                        context, route);
                                                  } else if (opcion ==
                                                      'borrar') {
                                                    int nino_id = nino['id'];
                                                    JardinProvider()
                                                        .ninoBorrar(nino_id)
                                                        .then((borradoOk) {
                                                      if (borradoOk) {
                                                        //pudo borrar
                                                        snap.data
                                                            .removeAt(index);
                                                        setState(() {});
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            duration: Duration(
                                                                seconds: 4),
                                                            content: Text(
                                                              'Niño ${nino['nombre']} ${nino['apellido']} borrado',
                                                              style: TextStyle(
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        );
                                                      } else {
                                                        //no pudo borrar
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                          SnackBar(
                                                            duration: Duration(
                                                                seconds: 4),
                                                            content: Text(
                                                                'El niño no se pudo borrar'),
                                                          ),
                                                        );
                                                      }
                                                    });
                                                  }
                                                },
                                              ),
                                            ),
                                            Container(
                                              width: 280.0,
                                              child: Text(
                                                'RUT: ${nino['rut']}',
                                                // '\nNacimiento: ${DateFormat.yMd().format(DateTime.parse(nino['fecha_nacimiento']))}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.5,
                                                ),
                                              ),
                                            ),
                                            Divider(
                                              indent: 17.0,
                                              endIndent: 80,
                                              thickness: 1,
                                              color: Colors.white,
                                            ),
                                            Container(
                                              height: 30,
                                              width: 280,
                                              child: Text(
                                                'Contacto: ${nino['contacto_apoderado']}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.5,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ))
                                      ],
                                    ),
                                  ))
                                : Container();
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

  void buscarDefault() {
    setState(() {
      print(widget.ninoBuscar);
      _controller.text = widget.ninoBuscar.trim();
    });
  }
}
