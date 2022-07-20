import 'package:app_jardin/pages/main_page_page.dart';
import 'package:app_jardin/pages/noticias/listado_noticias_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/google_provider.dart';
import '../noticias/listado_noticias_admin_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String usuario = '';
  String inicioUsuario = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 253, 227, 243),
      body: Center(
        child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(50),
            children: [
              Image(image: AssetImage('assets/images/logo.png')),
              StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    return ElevatedButton(
                      onPressed: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => ListaNoticiaAdminPage(),
                        );
                        Navigator.push(context, route);
                      },
                      child: Text(
                        'Ver Noticias',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return ElevatedButton(
                      onPressed: () {
                        MaterialPageRoute route = MaterialPageRoute(
                          builder: (context) => ListaNoticiaPage(),
                        );
                        Navigator.push(context, route);
                      },
                      child: Text(
                        'Ver Noticias',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                },
              ),
              StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasData) {
                    inicioUsuario = 'Sesión iniciada como ';
                    usuario =
                        FirebaseAuth.instance.currentUser!.displayName ?? '';
                    return ListView(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(0),
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            MaterialPageRoute route = MaterialPageRoute(
                              builder: (context) => MainPage(),
                            );
                            Navigator.push(context, route);
                          },
                          child: Text(
                            'Gestionar Jardín',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            inicioUsuario = '';
                            usuario = '';
                            final provider = Provider.of<GoogleProvider>(
                                context,
                                listen: false);
                            provider.googleLogout();
                          },
                          child: Text(
                            'Cerrar Sesión',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Divider(),
                        Text(
                          inicioUsuario + usuario,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('No se pudo iniciar sesion');
                  } else if (!snapshot.hasData) {
                    return ElevatedButton(
                      onPressed: () {
                        final provider =
                            Provider.of<GoogleProvider>(context, listen: false);
                        provider.googleLogin();
                      },
                      child: Text(
                        'Iniciar Sesión',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  } else {
                    return Text('');
                  }
                },
              ),
            ]),
      ),
    );
  }
}
