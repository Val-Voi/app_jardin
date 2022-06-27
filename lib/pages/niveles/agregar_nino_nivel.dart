import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../providers/jardin_provider.dart';

class NinoNivelForm extends StatefulWidget {
  NinoNivelForm({Key? key}) : super(key: key);

  @override
  State<NinoNivelForm> createState() => _NinoNivelFormState();
}

class _NinoNivelFormState extends State<NinoNivelForm> {
  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  List<String> items = [
    'AC',
    'B',
    'BBB',
    'CC',
    'D',
    'EEE',
    'FFFF',
    'G',
    'HHHHH',
    'III',
    'JJJ',
    'KKKK',
    'LL',
    'mmm'
  ];
  String errNino = '';
  final formKey = GlobalKey<FormState>();
  TextEditingController nombreCtrl = TextEditingController();

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
            DropdownButtonHideUnderline(
              child: DropdownButton2(
                isExpanded: true,
                hint: Text(
                  'Seleccionar niño',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value as String;
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
                  return (item.value.toString().contains(searchValue));
                },
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
            // DropdownButtonFormField(
            //   value: 'AC',
            //   hint: Text(
            //     'choose one',
            //   ),
            //   isExpanded: true,
            //   onChanged: (value) {
            //     setState(() {
            //       _selectedValue = value.toString();
            //     });
            //   },
            //   onSaved: (value) {
            //     setState(() {
            //       _selectedValue = value.toString();
            //     });
            //   },
            //   items: listOfValue.map((String val) {
            //     return DropdownMenuItem(
            //       value: val,
            //       child: Text(
            //         val,
            //       ),
            //     );
            //   }).toList(),
            // ),
            Container(
              width: double.infinity,
              child: Text(
                errNino,
                style: TextStyle(color: Colors.red),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                  child: Text('Agregar'),
                  onPressed: () async {
                    var respuesta = await JardinProvider().nivelAgregar(
                      nombreCtrl.text.trim(),
                    );

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
