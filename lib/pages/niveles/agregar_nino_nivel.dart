import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../providers/jardin_provider.dart';

class NinoNivelForm extends StatefulWidget {
  NinoNivelForm({Key? key}) : super(key: key);
  @override
  State<NinoNivelForm> createState() => _NinoNivelFormState();
}

class _NinoNivelFormState extends State<NinoNivelForm> {
  String? selectedNino;
  String? selectedNivel;
  final TextEditingController textEditingController = TextEditingController();
  String errNino = '';
  String errNivel = '';
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            FutureBuilder(
                future: JardinProvider().getNinos(),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List ninos = snap.data;
                  return DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      isExpanded: true,
                      hint: Text(
                        'Seleccionar niño',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).hintColor,
                        ),
                      ),
                      items: ninos
                          .map((item) => DropdownMenuItem<String>(
                                //value: item['nombre'] + ' ' + item['apellido'],
                                value: item['id'].toString(),

                                // id: item['id'];
                                child: Text(
                                  item['nombre'] + ' ' + item['apellido'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ))
                          .toList(),
                      value: selectedNino,
                      onChanged: (value) {
                        setState(() {
                          selectedNino = value as String;
                          print(selectedNino);
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 200,
                      itemHeight: 40,
                      dropdownMaxHeight: 200,
                      searchController: textEditingController,
                      searchInnerWidget: Padding(
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Nombre',
                            hintStyle: const TextStyle(fontSize: 12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return (item.child
                            .toString()
                            .toLowerCase()
                            .contains(searchValue.toLowerCase()));
                      },
                      //This to clear the search value when you close the menu
                      onMenuStateChange: (isOpen) {
                        if (!isOpen) {
                          textEditingController.clear();
                        }
                      },
                    ),
                  );
                }),
            Container(
              width: double.infinity,
              child: Text(
                errNino,
                style: TextStyle(color: Colors.red),
              ),
            ),
            FutureBuilder(
                future: JardinProvider().getNiveles(),
                builder: (context, AsyncSnapshot snap) {
                  if (!snap.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  List niveles = snap.data;
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
                          print(selectedNivel);
                        });
                      },
                      buttonHeight: 40,
                      buttonWidth: 200,
                      itemHeight: 40,
                      dropdownMaxHeight: 200,
                    ),
                  );
                }),
            Container(
              width: double.infinity,
              child: Text(
                errNivel,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  child: Text('Agregar'),
                  onPressed: () async {
                    var respuesta = await JardinProvider().ninoNivel(
                        int.parse(selectedNino!), int.parse(selectedNivel!));

                    if (respuesta['messages'] != null) {
                      print('error');
                      if (respuesta['errors']['nombre'] != null) {
                        errNino = respuesta['errors']['nombre'][0];
                      }

                      setState(() {});
                      return;
                    }
                    print('no error');
                    //  Navigator.pop(context);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
