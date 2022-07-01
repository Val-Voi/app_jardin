import 'package:app_jardin/pages/lista_eventos_page.dart';
import 'package:app_jardin/pages/niveles/agregar_a_nivel_page.dart';
import 'package:app_jardin/pages/niveles/menu_niveles_page.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app_jardin/pages/agregar_page.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:app_jardin/pages/niños/lista_ninos_page_copy.dart';
import 'educadoras/lista_educadoras_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index_agregar = 0;
  final GlobalKey<ExpansionTileCardState> cardNinos = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardEducadoras = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardEventos = new GlobalKey();
  final GlobalKey<ExpansionTileCardState> cardNiveles = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardin Pastelito'),
        backgroundColor: Color.fromARGB(255, 212, 146, 247),
        leading: Icon(MdiIcons.humanFemaleBoy),
      ),
      body: ListView(
        children: <Widget>[
// --------------------------- TARJETA NIÑOS --------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ExpansionTileCard(
              baseColor: Color.fromARGB(200, 130, 192, 241),
              expandedColor: Color.fromARGB(255, 130, 192, 241),
              key: cardNinos,
              leading: Icon(
                MdiIcons.humanChild,
                color: Colors.black,
              ),
              title: Text(
                "Gestionar Niños",
                style: TextStyle(color: Colors.black),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "Presione sobre 'Lista Niños' para ver una lista completa de los niños del jardín. En esta lista" +
                          " puede editar y borrar sus datos, así como también comprobar los eventos" +
                          " asociados a cada niño.\nPresione sobre 'Agregar Niño' para ingresar datos de un niño nuevo.",
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    TextButton(
                      onPressed: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return ListaNinosPage();
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            MdiIcons.formatListBulletedSquare,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Lista Niños',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: (() {
                        index_agregar = 0;
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarPage(
                            index_agregar: index_agregar,
                          );
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Nuevo Niño',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
// --------------------------- TARJETA EDUCADORAS------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ExpansionTileCard(
              baseColor: Color.fromARGB(210, 235, 93, 127),
              expandedColor: Color.fromARGB(255, 235, 93, 127),
              key: cardEducadoras,
              leading: Icon(
                MdiIcons.humanFemaleBoy,
                color: Colors.black,
              ),
              title: Text(
                "Gestionar Educadoras",
                style: TextStyle(color: Colors.black),
              ),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "Presione sobre 'Lista Educadoras' para ver una lista completa de las educadoras del jardín. En esta lista" +
                          " puede ver, editar y borrar los datos de cada una de ellas." +
                          " \nPresione sobre 'Agregar Educadora' para ingresar datos de una educadora nueva.",
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    TextButton(
                      onPressed: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return ListaEducadorasPage();
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            MdiIcons.formatListBulletedSquare,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Lista Educadoras',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: (() {
                        index_agregar = 1;
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarPage(
                            index_agregar: index_agregar,
                          );
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Nueva Educadora',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
// --------------------------- TARJETA EVENTOS --------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ExpansionTileCard(
              baseColor: Color.fromARGB(200, 244, 173, 102),
              expandedColor: Color.fromARGB(255, 244, 173, 102),
              key: cardNiveles,
              leading: Icon(
                MdiIcons.exclamationThick,
                color: Colors.black,
              ),
              title: Text("Gestionar Eventos",
                  style: TextStyle(color: Colors.black)),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "Presione sobre 'Lista Eventos' para ver una lista de todos los eventos ocurridos en el jardín. En esta lista" +
                          " puede ver los datos, editar y borrar cada evento." +
                          " \nPresione sobre 'Agregar Evento' para ingresar un evento nuevo.",
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    TextButton(
                      onPressed: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return ListaEventosPage();
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            MdiIcons.formatListBulletedSquare,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Lista Eventos',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: (() {
                        index_agregar = 3;

                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarPage(
                            index_agregar: index_agregar,
                          );
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Nuevo Evento',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
// --------------------------- TARJETA NIVELES --------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ExpansionTileCard(
              baseColor: Color.fromARGB(130, 255, 190, 11),
              expandedColor: Color.fromARGB(255, 255, 190, 11),
              key: cardEventos,
              leading: Icon(Icons.numbers, color: Colors.black),
              title: Text("Gestionar niveles",
                  style: TextStyle(color: Colors.black)),
              children: <Widget>[
                Divider(
                  thickness: 1.0,
                  height: 1.0,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "Presione sobre 'Lista Niveles' para ver una lista de todos los niveles del jardín. En esta lista" +
                          " puede editar y borrar cada nivel, así como también comprobar las personas" +
                          " asociadas a este.\nPresione sobre 'Agregar a Nivel' para asociar a un niño o educadora a un Nivel.\nPresione sobre 'Agregar Nivel' para ingresar un nivel nuevo.",
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    TextButton(
                      onPressed: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return MenuNivelesPage();
                        });
                        Navigator.push(context, route);
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            MdiIcons.formatListBulletedSquare,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Lista Niveles',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarANivelPage();
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            MdiIcons.arrowCollapse,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Agregar a Nivel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: (() {
                        index_agregar = 2;

                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarPage(
                            index_agregar: index_agregar,
                          );
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.black,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text(
                            'Nuevo Nivel',
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
