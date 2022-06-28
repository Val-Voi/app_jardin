import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Test extends StatefulWidget {
  Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  File? _file;
  void pickercamera() async {
    final myFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _file = File(myFile!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('subir imagen'),
      ),
      body: Column(
        children: <Widget>[
          ElevatedButton(onPressed: pickercamera, child: Text('Subir imagen')),
          Center(
              child: _file == null
                  ? Text('Seleccione una imagen')
                  : Image.file(_file!))
        ],
      ),
    );
  }
}
