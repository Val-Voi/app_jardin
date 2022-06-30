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
      body: Row(
        children: [
          Container(
            // decoration:
            //     BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(8.0))),
            width: 100,
            height: 100,
            alignment: Alignment.center,
            child: FutureBuilder(
              future: JardinProvider().getDataImagen('asd'),
              builder: (context, AsyncSnapshot<String> snapimagen) {
                if (!snapimagen.hasData) {
                  //print(snapimagen.data!.length);

                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapimagen.data!.length % 4 == 0) {
                  Uint8List imgdecoded = base64Decode(
                      snapimagen.data.toString().split('\n').join());
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
                  return CircleAvatar(
                    radius: 50,
                    backgroundImage: imagen,
                  );
                } else {
                  return Text('no imagen');
                }
                // return Text(base64Decode(snapimagen.data.toString()).toString());
                //return Text(snapimagen.data.toString());
                //return Text(imgdecoded.toString());s
              },
            ),
          ),
          Expanded(child: Text('¡asdsadsadas'))
        ],
      ),
    );
  }
}
