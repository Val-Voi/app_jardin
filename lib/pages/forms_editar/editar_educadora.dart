import 'package:app_jardin/pages/forms_editar/my_input_theme.dart';
import 'package:app_jardin/pages/forms_editar/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../../providers/jardin_provider.dart';

class EditarEducadoraPage extends StatefulWidget {
  int id;
  EditarEducadoraPage(this.id, {Key? key}) : super(key: key);
  @override
  State<EditarEducadoraPage> createState() => _EditarEducadoraPageState();
}

class _EditarEducadoraPageState extends State<EditarEducadoraPage> {
  TextEditingController idCtrl = TextEditingController();
  TextEditingController nombreCtrl = TextEditingController();
  TextEditingController rutCtrl = TextEditingController();
  TextEditingController telefonoCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController nivelCtrl = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Initial Selected Value
  String dropdownvalue = 'Nivel 1';

  // List of items in our dropdown menu
  var items = [
    'Nivel 1',
    'Nivel 2',
    'Nivel 3',
    'Nivel 4',
    'Nivel 5',
  ];
  @override
  void initState() {
    super.initState();

    JardinProvider().getEducadora(widget.id).then((data) {
      idCtrl.text = data['id'].toString();
      nombreCtrl.text = data['nombre'];
      rutCtrl.text = data['rut'];
      telefonoCtrl.text = data['telefono_contacto'];
      emailCtrl.text = data['correo_contacto'];

      // telefono_contacto,
      // String correo_contacto
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        inputDecorationTheme: MyInputTheme().theme(),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Editar Educadora'),
          backgroundColor: Colors.orange,
        ),
        body: Form(
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
                  helperText: "",
                  hintText: "Ana Rodhes",
                ),
              ),

              //Fin NOMBRE

              //RUT
              TextFormField(
                controller: rutCtrl,
                keyboardType: TextInputType.numberWithOptions(),
                decoration: InputDecoration(
                  labelText: "Rut",
                  helperText: "",
                  hintText: "20.320.487-6",
                ),
              ),

              //Fin RUT

              //TELEFONO
              TextFormField(
                controller: telefonoCtrl,
                keyboardType: TextInputType.numberWithOptions(
                    decimal: false, signed: true),
                maxLength: 8,
                decoration: InputDecoration(
                  labelText: "Telefóno",
                  helperText: "",
                  hintText: "",
                  prefix: Text("+569"),
                ),
              ),

              //Fin TELEFONO

              //Correo
              TextFormField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                validator: (s) {
                  if (!s!.isValidEmail()) {
                    return "Ingrese Email Valido";
                  }
                },
                decoration: InputDecoration(
                  labelText: "E-mail",
                  helperText: "",
                  hintText: "email@ejemplo.com",
                ),
              ),

              //Fin correo

              //DROPDOWN DE NIVELES
              SizedBox(
                width: 240,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(width: 3, color: Colors.blue),
                    ),
                  ),
                  value: dropdownvalue,
                  icon: Icon(MdiIcons.arrowDown),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              )

              //FINAL DROPDOWN DE NIVELES
            ]
                .map((child) => Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: child,
                    ))
                .toList(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            JardinProvider().educadoraEditar(
              widget.id,
              //int.tryParse(idCtrl.text.trim()) ?? 0,
              nombreCtrl.text.trim(),
              rutCtrl.text.trim(),
              '9' + telefonoCtrl.text.trim(),
              emailCtrl.text.trim(),
            );
            Navigator.pop(context);
          },
          child: Icon(MdiIcons.contentSave),
        ),
      ),
    );
  }
}
