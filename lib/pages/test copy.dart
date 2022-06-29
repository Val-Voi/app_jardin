import 'dart:typed_data';

import 'package:app_jardin/providers/jardin_provider.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';

class pagina2 extends StatefulWidget {
  @override
  _pagina2State createState() => _pagina2State();
}

class _pagina2State extends State<pagina2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: JardinProvider().getDataImagen('asd'),
        builder: (context, AsyncSnapshot<String> snapimagen) {
          if (!snapimagen.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            Uint8List imgdecoded =
                base64Decode(snapimagen.data.toString().split('\n').join());
            //print(snapimagen);
            // return Image(
            //   image: Image.memory(
            //           base64Decode(snapimagen.data.toString()))
            //       .image,
            // ); //TODO: MOSTRAR IMAGEN
            // final decodedBytes =
            //     base64Decode(snapimagen.data.toString());
            // var file = Io.File("decodedBezkoder.png");
            // file.writeAsBytesSync(decodedBytes);
            // return Center(
            //     // child: Text('gdsaddn'),
            //     child: Image(
            //   image: Image.memory(base64Decode(snapimagen.data.toString())).image,
            // ));Uint8Lists

            // // );
            ImageProvider imagen = Image.memory(imgdecoded).image;
            return Image(
              image: imagen,
            );
          }
          // return Text(base64Decode(snapimagen.data.toString()).toString());
          //return Text(snapimagen.data.toString());
          //return Text(imgdecoded.toString());
        },
      ),
    );
  }
}
