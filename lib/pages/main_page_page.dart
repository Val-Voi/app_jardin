import 'package:app_jardin/pages/lista_eventos_page.dart';
// import 'package:app_jardin/pages/ni%C3%B1os/lista_ni%C3%B1os_page.dart';
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
        title: Text('Jardin App'),
        backgroundColor: Color.fromARGB(255, 136, 236, 74),
        leading: Icon(MdiIcons.humanChild),
      ),
      body: ListView(
        children: <Widget>[
// --------------------------- TARJETA NIÑOS --------------------------------
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: ExpansionTileCard(
              baseColor: Colors.cyan[50],
              expandedColor: Colors.red[50],
              key: cardNinos,
              leading: Icon(MdiIcons.humanChild),
              title: Text("Gestionar Niños"),
              subtitle: Text("niños"),
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
                      "sd jks dksa ",
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
                          return ListaNinosPage(); //debo poner la pagina agregar
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(MdiIcons.formatListBulletedSquare),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Lista Niños'),
                        ],
                      ),
                    ),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 209, 223, 224),
                        side: BorderSide(
                            color: Color.fromARGB(255, 47, 0, 255),
                            style: BorderStyle.solid),
                      ),
                      onPressed: (() {
                        index_agregar = 0;
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarPage(
                            index_agregar: index_agregar,
                          ); //debo poner la pagina agregar
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_upward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Agregar Niño'),
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
              baseColor: Colors.cyan[50],
              expandedColor: Colors.red[50],
              key: cardEducadoras,
              leading: Icon(MdiIcons.humanChild),
              title: Text("Gestionar Educadoras"),
              subtitle: Text("educadoras"),
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
                      "dsa idojis od",
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return ListaEducadorasPage(); //debo poner la pagina agregar
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_downward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Lista Educadoras'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (() {
                        index_agregar = 1;
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarPage(
                            index_agregar: index_agregar,
                          ); //debo poner la pagina agregar
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_upward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Agregar Educadora'),
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
              baseColor: Colors.cyan[50],
              expandedColor: Colors.red[50],
              key: cardNiveles,
              leading: Icon(MdiIcons.humanChild),
              title: Text("Gestionar Eventos"),
              subtitle: Text("eventos"),
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
                      "sdjfdskfdsf",
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return ListaEventosPage(); //debo poner la pagina agregar
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_downward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Lista Eventos'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (() {
                        index_agregar = 3;

                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarPage(
                            index_agregar: index_agregar,
                          ); //debo poner la pagina agregar
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_upward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Agregar Evento'),
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
              baseColor: Colors.cyan[50],
              expandedColor: Colors.red[50],
              key: cardEventos,
              leading: Icon(MdiIcons.humanChild),
              title: Text("Gestionar niveles"),
              subtitle: Text("niveles"),
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
                      "sdjfdskfdsf",
                    ),
                  ),
                ),
                ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  buttonHeight: 52.0,
                  buttonMinWidth: 90.0,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return MenuNivelesPage(); //debo poner la pagina agregar
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_downward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Ver Niveles'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (() {
                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarANivelPage(); //debo poner la pagina agregar
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_upward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Agregar a Nivel'),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: (() {
                        index_agregar = 2;

                        MaterialPageRoute route =
                            MaterialPageRoute(builder: (context) {
                          return AgregarPage(
                            index_agregar: index_agregar,
                          ); //debo poner la pagina agregar
                        });
                        Navigator.push(context, route).then((value) {
                          setState(() {});
                        });
                      }),
                      child: Column(
                        children: <Widget>[
                          Icon(Icons.arrow_upward),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 2.0),
                          ),
                          Text('Nuevo Nivel'),
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
