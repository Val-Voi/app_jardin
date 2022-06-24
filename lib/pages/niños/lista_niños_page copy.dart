import 'package:app_jardin/pages/forms_agregar/agregar_educadora.dart';
import 'package:app_jardin/pages/forms_agregar/agregar_ni%C3%B1o.dart';
import 'package:app_jardin/pages/main_page_page.dart';
import 'package:app_jardin/providers/jardin_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:app_jardin/main.dart';
import 'package:intl/date_symbol_data_file.dart';

class ListaNinosPage extends StatefulWidget {
  ListaNinosPage({Key? key}) : super(key: key);

  @override
  State<ListaNinosPage> createState() => _ListaNinosPageState();
}

class _ListaNinosPageState extends State<ListaNinosPage> {
  int _contadorColor = 0;
  List<Color> colores = [
    Color.fromARGB(255, 88, 168, 252),
    Color.fromARGB(255, 234, 100, 132),
    Color.fromARGB(255, 185, 123, 243),
    Color.fromARGB(255, 244, 174, 102),
    Color.fromARGB(255, 100, 226, 210),
  ];

//  @override
//   void initState() {
//     super.initState();
//   initializeDateFormatting('de_DE', null).then((_) => runMyCode());
//   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Jardin App'),
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
                            return Center(
                                child: Card(
                              color: color(),
                              child: Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    alignment: Alignment.center,
                                    
                                    // color: Colors.grey,
                                    child: Text('probando'),),
                                  Expanded(child: Column(
                                    

                                    children: [
                                      ListTile(
                                        
                                        title: Text(
                                          '${nino['nombre']}',
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                          'Nivel ${nino['niveles_id']}',
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
                                                builder: (context) => AgregarNino(),
                                              );
                                              Navigator.push(context, route);
                                            } else {
                                              int nino_id = nino['id'];

                                              JardinProvider()
                                                  .ninoBorrar(nino_id)
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
                                                        'Niño ${nino['nombre']} borrado',
                                                        style:
                                                            TextStyle(fontSize: 16),
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
                                        width: 270.0,
                                        // height: 50.0,
                                        // color: Colors.grey,
                                        child: Text(
                                          'RUT: ${nino['rut']}',
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
                                          'Contacto: ${nino['contacto_apoderado']}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                  )
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
