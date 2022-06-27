import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../providers/jardin_provider.dart';
import '../forms_editar/editar_educadora.dart';

class ListaEducadorasPage extends StatefulWidget {
  ListaEducadorasPage({Key? key}) : super(key: key);

  @override
  State<ListaEducadorasPage> createState() => _ListaEducadorasPageState();
}

class _ListaEducadorasPageState extends State<ListaEducadorasPage> {
  int _contadorColor = 0;
  List<Color> colores = [
    Color.fromARGB(255, 88, 168, 252),
    Color.fromARGB(255, 234, 100, 132),
    Color.fromARGB(255, 185, 123, 243),
    Color.fromARGB(255, 244, 174, 102),
    Color.fromARGB(255, 100, 226, 210),
  ];
  String buscarEducadora = "";

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
          child: Container(
            child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    setState(() {
                      buscarEducadora = value.toLowerCase();
                    });
                  },
                  decoration: InputDecoration(
                      labelText: 'Buscar Educadora',
                      suffixIcon: Icon(MdiIcons.searchWeb)),
                ),
                Expanded(
                  child: FutureBuilder(
                    future: JardinProvider().getEducadoras(),
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
                                  .contains(buscarEducadora)
                              ? Divider()
                              : Container();
                        },
                        itemCount: snap.data.length,
                        itemBuilder: (context, index) {
                          var profe = snap.data[index];
                          return snap.data![index]['nombre']
                                  .toLowerCase()
                                  .contains(buscarEducadora)
                              ? Center(
                                  child: Card(
                                  color: color(),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 100,
                                        alignment: Alignment.center,
                                        child: Text('probando'),
                                      ),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          ListTile(
                                            title: Text(
                                              '${profe['nombre']}',
                                              style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            subtitle: Text(
                                              'Nivel ${profe['niveles_id']}',
                                              style: TextStyle(
                                                color: Colors.white,
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
                                                        EditarEducadoraPage(),
                                                  );
                                                  Navigator.push(
                                                      context, route);
                                                } else if (opcion == 'borrar') {
                                                  int profe_id = profe['id'];
                                                  JardinProvider()
                                                      .educadoraBorrar(profe_id)
                                                      .then((borradoOk) {
                                                    if (borradoOk) {
                                                      //pudo borrar
                                                      snap.data.removeAt(index);
                                                      setState(() {});
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          duration: Duration(
                                                              seconds: 4),
                                                          content: Text(
                                                            'Educador/a ${profe['nombre']} borrado',
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
                                                              'El educador/a no se pudo borrar'),
                                                        ),
                                                      );
                                                    }
                                                  });
                                                }
                                              },
                                            ),
                                          ),
                                          Container(
                                            width: 270.0,
                                            child: Text(
                                              'RUT: ${profe['rut']}',
                                              // '\nNacimiento: ${DateFormat.yMd().format(DateTime.parse(nino['fecha_nacimiento']))}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
                                              ),
                                            ),
                                          ),
                                          Divider(
                                            indent: 70.0,
                                            endIndent: 140,
                                            thickness: 5,
                                            color: Colors.black,
                                          ),
                                          Container(
                                            child: Text(
                                              'Contacto: ${profe['telefono_contacto']}'
                                              '\nCorreo: ${profe['correo_contacto']}',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0,
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
          )),
    );
  }

  Color color() {
    _contadorColor++;
    if (_contadorColor >= 5) {
      _contadorColor = 0;
    }
    return colores[_contadorColor];
  }
}
