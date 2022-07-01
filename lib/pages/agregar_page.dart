import 'package:app_jardin/pages/forms_agregar/agregar_educadora.dart';
import 'package:app_jardin/pages/forms_agregar/agregar_evento.dart';
import 'package:app_jardin/pages/forms_agregar/agregar_ni%C3%B1o.dart';
import 'package:app_jardin/pages/forms_agregar/agregar_nivel.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class AgregarPage extends StatefulWidget {
  final int index_agregar;
  AgregarPage({Key? key, required this.index_agregar}) : super(key: key);

  @override
  State<AgregarPage> createState() => _AgregarPageState();
}

class _AgregarPageState extends State<AgregarPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreCtrl = TextEditingController();

  String errNombre = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agregar datos'),
        backgroundColor: Color.fromARGB(255, 130, 192, 241),
        leading: BackButton(),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: DefaultTabController(
          length: 4,
          child: ListView(
            children: [
              ToggleFormButton(
                index_agregar: widget.index_agregar,
              ),
              Container(
                alignment: Alignment.center,
              ),
              Container(
                  height: 600.0,
                  width: 333.0,
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        AgregarNinoPage(),
                        AgregarEducadoraPage(),
                        AgregarNivel(),
                        AgregarEventoPage()
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}

class ToggleFormButton extends StatefulWidget {
  final int index_agregar;
  ToggleFormButton({Key? key, required this.index_agregar}) : super(key: key);

  @override
  State<ToggleFormButton> createState() => _ToggleFormButtonState();
}

class _ToggleFormButtonState extends State<ToggleFormButton> {
  final List<bool> _isSelected = List.generate(4, (_) => false);

  @override
  void initState() {
    _isSelected[widget.index_agregar] = true;
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => defaultForm());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ToggleButtons(
        borderRadius: BorderRadius.circular(25),
        children: <Widget>[
          Tab(
            text: 'Niño',
            icon: Icon(MdiIcons.humanChild),
          ),
          Tab(
            text: 'Educadora',
            icon: Icon(MdiIcons.humanFemaleBoy),
          ),
          Tab(
            text: 'Nivel',
            icon: Icon(Icons.numbers),
          ),
          Tab(
            text: 'Evento',
            icon: Icon(MdiIcons.exclamationThick),
          )
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
                } else if (index == 2) {
                  DefaultTabController.of(context)?.animateTo(2);
                } else if (index == 3) {
                  DefaultTabController.of(context)?.animateTo(3);
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

  void defaultForm() {
    if (widget.index_agregar == 0) {
      DefaultTabController.of(context)?.animateTo(0);
    } else if (widget.index_agregar == 1) {
      DefaultTabController.of(context)?.animateTo(1);
    } else if (widget.index_agregar == 2) {
      DefaultTabController.of(context)?.animateTo(2);
    } else if (widget.index_agregar == 3) {
      DefaultTabController.of(context)?.animateTo(3);
    }
  }
}
