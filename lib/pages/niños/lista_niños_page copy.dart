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
                          return Center(
                            child: Card(
                              color: colores(),
                              child: Column(
                                
                              children: [
                                ListTile(
                                  
                                  leading: Icon(MdiIcons.humanChild),
                                  title: Text('${nino['id']} ${nino['nombre']}'),
                                  subtitle: Text('RUT: ${nino['rut']}'),
                                ),
                              ],
                            ),
                            )
                            
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            )));
  }
}

colores() {
  return Colors.blueAccent;
}
