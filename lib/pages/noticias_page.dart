import 'package:app_jardin/providers/google_provider.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'main_page_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoticiasPage extends StatefulWidget {
  NoticiasPage({Key? key}) : super(key: key);

  @override
  State<NoticiasPage> createState() => _NoticiasPageState();
}

class _NoticiasPageState extends State<NoticiasPage> {
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Jardin Pastelito'),
          backgroundColor: Color.fromARGB(255, 212, 146, 247),
          leading: BackButton(),
        ),
        body: Text('Página de Noticias'));
  }
}
