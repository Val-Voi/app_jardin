import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../providers/jardin_provider.dart';

class EditarNinoPage extends StatefulWidget {
  final int id;
  final String nivel_actual;
  EditarNinoPage({Key? key, required this.id, required this.nivel_actual})
      : super(key: key);

  @override
  State<EditarNinoPage> createState() => _EditarNinoPageState();
}

class _EditarNinoPageState extends State<EditarNinoPage> {
  TextEditingController idCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController apellidoCtrl = TextEditingController();
  TextEditingController fecha_nacCtrl = TextEditingController();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController contactoCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  String? selectedNivel;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => nivelDedault());
  }
  // late DateTime _dateTime;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: MyInputTheme().theme(),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Editar Niño'),
          backgroundColor: Color.fromARGB(255, 130, 192, 241),
        ),
        body: FutureBuilder(
            future: JardinProvider().getNino(widget.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var data = snapshot.data;
              nombreCtrl.text = data['nombre'];
              apellidoCtrl.text = data['apellido'];
              fecha_nacCtrl.text = data['fecha_nacimiento'].toString();
              rutCtrl.text = data['rut'];
              contactoCtrl.text = data['contacto_apoderado'];
              //selectedNivel = data['nivel_id'].toString();

              return Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(32.0),
                  children: <Widget>[
                    // CampoNombre(),

                    //NOMBRE
                    TextFormField(
                      controller: nombreCtrl,
                      decoration: InputDecoration(
                        labelText: "Nombre",
                      ),
                    ),

                    //Fin NOMBRE
                    //APELLIDO
                    TextFormField(
                      controller: apellidoCtrl,
                      decoration: InputDecoration(
                        labelText: "Apellido",
                      ),
                    ),
                    //FIN APELLIDO
                    //RUT
                    TextFormField(
                      controller: rutCtrl,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        labelText: "Rut",
                      ),
                    ),
                    //Fin RUT
                    //FECHA NAC
                    //  Text(_dateTime == null ? 'No se ha seleccionado nada': _dateTime.toString())
                    //  showDatePicker(
                    //   context: context,
                    //   initialDate: DateTime.now(),
                    //   firstDate: DateTime(2001),
                    //   lastDate: DateTime(2022)
                    //  ).then((date){
                    //   setState(() {
                    //                _dateTime = date;
                    //                 });
                    //  })
                    //Fin fehca nac

                    //CONTACTO
                    TextFormField(
                      controller: contactoCtrl,
                      decoration: InputDecoration(
                        labelText: "Contacto",
                      ),
                    ),
                    //FIN CONTACTO
                    FutureBuilder(
                        future: JardinProvider().getNiveles(),
                        builder: (context, AsyncSnapshot snapNivel) {
                          if (!snapNivel.hasData) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          List niveles = snapNivel.data;
                          return DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Text(
                                'Seleccionar nivel',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).hintColor,
                                ),
                              ),
                              items: niveles
                                  .map((item) => DropdownMenuItem<String>(
                                        value: item['id'].toString(),
                                        child: Text(
                                          item['nombre'],
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                              value: selectedNivel,
                              onChanged: (value) {
                                setState(() {
                                  selectedNivel = value as String;
                                });
                              },
                              buttonHeight: 40,
                              buttonWidth: 200,
                              itemHeight: 40,
                              dropdownMaxHeight: 200,
                            ),
                          );
                        }),
                    ElevatedButton(
                      onPressed: () async {
                        print(widget.id.toString() +
                            nombreCtrl.text.trim() +
                            apellidoCtrl.text.trim() +
                            rutCtrl.text.trim() +
                            contactoCtrl.text.trim() +
                            fecha_nacCtrl.text.trim() +
                            selectedNivel!);
                        var respuesta = await JardinProvider().ninoEditar(
                            widget.id,
                            nombreCtrl.text.trim(),
                            apellidoCtrl.text.trim(),
                            rutCtrl.text.trim(),
                            contactoCtrl.text.trim(),
                            fecha_nacCtrl.text.trim(),
                            int.parse(selectedNivel!));
                        if (respuesta['messages'] != null) {
                          print('error');
                          if (respuesta['errors']['nombre'] != null) {
                            //errNombre = respuesta['errors']['nombre'][0];
                          }

                          setState(() {});
                          return;
                        }
                        print('no error');
                        //Navigator.pop(context);
                      },
                      child: Text('Guardar niño'),
                    ),
                    //Fin NIVEL
                  ]
                      .map((child) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: child,
                          ))
                      .toList(),
                ),
              );
            }),
      ),
    );
  }

  void nivelDedault() {
    selectedNivel = widget.nivel_actual;
  }
}
