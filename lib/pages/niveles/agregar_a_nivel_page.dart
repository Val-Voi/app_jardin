import 'package:app_jardin/pages/niveles/agregar_educadora_nivel.dart';
import 'package:app_jardin/pages/niveles/agregar_nino_nivel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AgregarANivelPage extends StatefulWidget {
  AgregarANivelPage({Key? key}) : super(key: key);

  @override
  State<AgregarANivelPage> createState() => _AgregarANivelPageState();
}

class _AgregarANivelPageState extends State<AgregarANivelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar a Nivel'),
        backgroundColor: Color.fromARGB(255, 136, 236, 74),
        leading: BackButton(),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          length: 2,
          child: ListView(
            children: [
              ToggleFormButtonNiveles(),
              Container(
                alignment: Alignment.center,
              ),
              Container(
                  height: 295.0,
                  width: 333.0,
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        NinoNivelForm(),
                        EducadoraNivelForm(),
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}

class ToggleFormButtonNiveles extends StatefulWidget {
  ToggleFormButtonNiveles({
    Key? key,
  }) : super(key: key);

  @override
  State<ToggleFormButtonNiveles> createState() =>
      _ToggleFormButtonNivelesState();
}

class _ToggleFormButtonNivelesState extends State<ToggleFormButtonNiveles> {
  final List<bool> _isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ToggleButtons(
        children: <Widget>[
          Tab(
            text: 'Niño',
            icon: Icon(MdiIcons.humanChild),
          ),
          Tab(
            text: 'Educadora',
            icon: Icon(MdiIcons.human),
          ),
        ],
        onPressed: (int index) {
          setState(() {
            for (int buttonIndex = 0;
                buttonIndex < _isSelected.length;
                buttonIndex++) {
              if (buttonIndex == index) {
                _isSelected[buttonIndex] = true;
                if (index == 0) {
                  DefaultTabController.of(context)?.animateTo(0);
                } else if (index == 1) {
                  DefaultTabController.of(context)?.animateTo(1);
                }
              } else {
                _isSelected[buttonIndex] = false;
              }
            }
            ;
          });
        },
        isSelected: _isSelected,
      ),
    );
  }
}
