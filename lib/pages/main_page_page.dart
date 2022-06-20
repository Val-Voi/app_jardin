import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:app_jardin/pages/agregar_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jardin App'),
        backgroundColor: Color.fromARGB(255, 136, 236, 74),
        leading: Icon(MdiIcons.humanChild),
      ),
      body: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              child: ElevatedButton(
                child: Text('Agregar'),
                onPressed: (() {
                  MaterialPageRoute route =
                      MaterialPageRoute(builder: (context) {
                    return AgregarPage(); //debo poner la pagina agregar
                  });
                  Navigator.push(context, route).then((value) {
                    print('VEAMOS SI LO MUESTRA');
                    setState(() {});
                  });
                }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
