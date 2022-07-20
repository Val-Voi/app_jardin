import 'package:app_jardin/pages/noticias/editar_noticias_page.dart';
import 'package:flutter/material.dart';
import '../../providers/jardin_provider.dart';


class ListaNoticiaPage extends StatefulWidget {
  ListaNoticiaPage({Key? key}) : super(key: key);

  @override
  State<ListaNoticiaPage> createState() => _ListaNoticiaPageState();
}

class _ListaNoticiaPageState extends State<ListaNoticiaPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Noticias'),
          backgroundColor: Color.fromARGB(255, 185, 123, 243),
          leading: BackButton(),
      ),
      
    );
  }



}