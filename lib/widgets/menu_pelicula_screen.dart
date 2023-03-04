import 'package:ecuafilms/controllers/perfil_controller.dart';
import 'package:ecuafilms/main.dart';
import 'package:ecuafilms/models/usuario_model.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MenuPelicula extends StatefulWidget {
  const MenuPelicula({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _Menu createState() => _Menu();
}

class _Menu extends State<MenuPelicula> {
  final Perfil datosPerfil = Perfil();
  final User? userFirebase = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFF242A32)),
            accountName: const Text(
              'Bienvenido',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            accountEmail: Text(
              userFirebase!.email.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            currentAccountPicture: const FlutterLogo(),
          ),
          drawerItem(
              icon: Icons.movie,
              text: 'Peliculas',
              onTap: () => Navigator.pushNamed(context, 'home')),
          drawerItem(
              icon: Icons.person,
              text: 'Perfil',
              onTap: () => Navigator.pushNamed(context, 'perfil_usuario')),
          drawerItem(
              icon: Icons.exit_to_app,
              text: 'Cerrar Sesión',
              onTap: () {
                FirebaseAuth.instance.signOut().then((value) => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MyApp())));
              }),
        ],
      ),
    );
  }

  Widget drawerItem({IconData? icon, String? text, GestureTapCallback? onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text!),
      onTap: onTap,
    );
  }
}
